const _ = require("underscore");
const fs = require('fs');
const config = require('config');
const { v5: uuidv5 } = require('uuid');
const xlsx = require('node-xlsx');
const path = require('path');
const axios = require('axios');
const Promise = require("bluebird");

const output_folder = config.get("output_folder");
const benchmarks_folder = config.get("benchmarks_folder");


function generateOutputFolder() {
    if (!fs.existsSync(output_folder)) {
        console.log("Creating output folder:", output_folder);
        fs.mkdirSync(output_folder);
    }
}

function parseReferences(references) {
    if (!references) {
        return Promise.resolve(null);
    }
    return Promise.map(references.replaceAll(":http", "\nhttp").split("\n"), (link) => {
        return axios.head(link)
        .then(res => {
            if (res.status == 200) {
                return link;
            } else {
                return '';
            }
        }).catch(err => {
            return '';
        })
    }).then(results => {
        return results.filter(el => {return el}); // filter empty results
    });
}

function parseAllSections(data) {
    let arr = _.filter(data, (el) => {
        return (el["section #"] && el["title"] && !el["recommendation #"]);
    });
    arr = _.map(arr, i => _.pick(i, ["section #", "title"]));
    return arr;
}

function identifySection(rule_section, sections) {
    for (section of sections) {
        if (section["section #"] == rule_section) {
            return section.title;
        }
    }
    // we should never get here!
    console.err("Could not find section for rule", rule_section);
    process.exit(-1);
}

function normalizeResults(data, metadata) {
    const sections = parseAllSections(data); // mapping betweem section # and its title. For example: { 'section #': '1', title: 'Control Plane Components' }

    let result = _.filter(data, (it) => {
        return it["recommendation #"]
    });

    return Promise.map(result, (it) => {
        return parseReferences(it.references)
        .then((references) => {
            return {
                "id": uuidv5(`${metadata.benchmark.name} ${it.Title}`, config.get("uuid_seed")),
                "name": it.Title,
                "rule_number": it["recommendation #"],
                "profile_applicability": `* ${metadata.profile_applicability}`,
                "description": it.description,
                "rationale":  it["rational statement"],
                "audit": it["audit procedure"],
                "remediation": it["remediation procedure"],
                "impact": it["impact statement"],
                // "default_value": "By default, profiling is enabled.\n", // TODO
                "references": references,
                "section": identifySection(it["section #"], sections),
                "benchmark": metadata.benchmark
            }
        });
    });
}

function parseSpreadsheet(tab, benchmark_metadata) {
    const profile_applicability = tab.name;
    const result = [];
    const keys = tab.data[0].map(el => el.toLowerCase()); // Different benchamrks have different casing in the columns titles
    for (let idx=1; idx<tab.data.length; idx++) {
        const values = tab.data[idx];
        result.push(Object.assign.apply({}, keys.map((v, i) => ({[v]: values[i]}))));
    }

    return normalizeResults(result, {
        "profile_applicability": profile_applicability,
        "benchmark": benchmark_metadata
    });
}

function parseBenchmark(file, benchmark_metadata) {
    const obj = xlsx.parse(file);
    return Promise.map(obj, (tab) => {
        // Assumption, we treat only tabs that start with the word "Level" (as in the string "Level 1 - Master Node")
        if (tab.name.indexOf("Level") != 0) {
            return Promise.resolve();
        }
        return parseSpreadsheet(tab, benchmark_metadata)
        .then(res => {
            // for debug
            // console.log("Parsed", res.length, "rules from", tab.name, "in", benchmark_metadata);
            return res;
        })
    }).then(final_result => {
        return final_result.flat().filter(el => {return el}); // remove empty results
    });
}

function parseBenchmarks(folder) {
    const files = fs.readdirSync(folder);
    return Promise.map(files, (file) => {
        const file_path = __dirname + "/" + folder + "/" + file;
        const filename = path.parse(file).name;
        const tokens = filename.split("_");
        const pivot = tokens.indexOf("Benchmark");
        const benchamrk = {
            "name": tokens.slice(0, pivot).join(" "), // assuming the "Benchmark" word seperates the benchmark name and the benchmark version
            "version": tokens.slice(-1)[0]            // assuming the version is always the last token in the string
        }

        return parseBenchmark(file_path, benchamrk)
        .then(res => {
            return {
                "filename": filename,
                "rules": res
            }
        });
    });
}

// Make sure output folder exists
generateOutputFolder();

parseBenchmarks(benchmarks_folder)
.then((benchmarks) => {
    for (benchmark of benchmarks) {
        console.log("Parsed total of", benchmark.rules.length, "rules in benchamrk", benchmark.filename);
        fs.writeFileSync(output_folder + "/" + benchmark.filename + ".json", JSON.stringify(benchmark.rules));
    }
    
    console.log("Done!");
});

