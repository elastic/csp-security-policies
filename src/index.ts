import _ from "underscore";
import fs from 'fs';
import config from 'config';
const { v5: uuidv5 } = require('uuid');
import xlsx from 'node-xlsx';
import path from 'path';
// import axios from 'axios';
import Promise from "bluebird";

const output_folder: string = config.get("output_folder");
const benchmarks_folder: string = config.get("benchmarks_folder");

function generateOutputFolder(): void {
    if (!fs.existsSync(output_folder)) {
        console.log("Creating output folder:", output_folder);
        fs.mkdirSync(output_folder);
    }
}

function parseReferences(references): Promise<null | string[]> {
    if (!references) {
        return Promise.resolve(null);
    }

    const links: string[] = references.replaceAll(":http", "\nhttp").split("\n");
    return Promise.resolve(links);

    // TODO - fix the axios logic, i'm seeing valid links identified as broken...
    // could be retry, could be throttling from the websites.
    // perhaps we should add some caching, or maybe we can just ignore broken links.
    // return Promise.map(links, (link) => {
    //     return axios.head(link)
    //         .then(res => {
    //             return res.config.baseURL;
    //         }).catch(err => {
    //             if (err.response) {
    //                 console.log("Got", err.response.status, "for", err.config.baseURL);
    //             } else {
    //                 console.log("Got", err.code, "for", err.config.baseURL);
    //             }
    //             return '';
    //         })
    // }).then(results => {
    //     return results.filter(el => { return el }); // filter empty results
    // });
}

// Generate a mapping betweem section # and its title. 
// For example: { 'section #': '1', title: 'Control Plane Components' }
function parseAllSections(data): SectionMetadata[] {
    let arr = _.filter(data, (el) => {
        return (el["section #"] && el["title"] && !el["recommendation #"]);
    });
    arr = _.map(arr, i => _.pick(i, ["section #", "title"]));
    return arr;
}

function identifySection(rule_section: string, sections: SectionMetadata[]): string {
    for (const section of sections) {
        if (section["section #"] == rule_section) {
            return section.title;
        }
    }
    // we should never get here!
    console.log("FATAL: Could not find section for rule", rule_section);
    process.exit(-1);
}

function extractValue(rule: BenchmarksData, keys: string[]): string {
    let result = "";
    for (const key of keys) {
        if (key in rule) {
            result = rule[key];
            break;
        }
    }
    return result || "";
}

function normalizeResults(data: BenchmarksData[], benchmark_metadata: BenchmarkMetadata,
    profile_applicability: string) {
    const sections = parseAllSections(data);

    let result = _.filter(data, (it) => {
        return Boolean(extractValue(it, ["recommendation #"]));
    });

    return Promise.map(result, (it) => {
        const rule_name = extractValue(it, ["title"]);
        console.log("Parsing:", benchmark_metadata.name, rule_name);
        return parseReferences(extractValue(it, ["references"]))
            .then((references) => {
                return {
                    "id": uuidv5(`${benchmark_metadata.name} ${rule_name}`, config.get("uuid_seed")),
                    "name": rule_name,
                    "rule_number": extractValue(it, ["recommendation #"]),
                    "profile_applicability": `* ${profile_applicability}`,
                    "description": extractValue(it, ["description"]),
                    "rational": extractValue(it, ["rational statement", "rationale statement"]),
                    "audit": extractValue(it, ["audit procedure"]),
                    "remediation": extractValue(it, ["remediation procedure"]),
                    "impact": extractValue(it, ["impact statement"]),
                    // "default_value": "By default, profiling is enabled.\n", // TODO
                    "references": references,
                    "section": identifySection(extractValue(it, ["section #"]), sections),
                    "benchmark": benchmark_metadata
                };
            });
    });
}

function parseSpreadsheet(tab, benchmark_metadata: BenchmarkMetadata) {
    const profile_applicability = tab.name;
    const results: BenchmarksData[] = [];
    const keys = tab.data[0].map(el => el.toLowerCase()); // Different benchamrks have different casing in the columns titles
    for (let idx = 1; idx < tab.data.length; idx++) {
        const values = tab.data[idx];
        results.push(Object.assign.apply({}, keys.map((v, i) => ({ [v]: values[i] }))));
    }

    return normalizeResults(results, benchmark_metadata, profile_applicability);
}

function parseBenchmark(file, benchmark_metadata: BenchmarkMetadata): Promise<RuleSchema[]> {
    const obj = xlsx.parse(file);
    return Promise.map(obj, tab => {
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
        return final_result.flat().filter(el => { return el }); // remove empty results
    });
}

function parseBenchmarks(folder): Promise<BenchmarkSchema[]> {
    const files = fs.readdirSync(folder);
    return Promise.map(files, (file) => {
        const file_path = folder + "/" + file;
        const filename = path.parse(file).name;
        const tokens = filename.split("_");
        const pivot = tokens.indexOf("Benchmark");
        const benchamrk: BenchmarkMetadata = {
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
        for (const benchmark of benchmarks) {
            console.log("Parsed total of", benchmark.rules.length, "rules in benchamrk", benchmark.filename);
            fs.writeFileSync(output_folder + "/" + benchmark.filename + ".json", JSON.stringify(benchmark.rules));
        }

        console.log("Done!");
    });

export { };