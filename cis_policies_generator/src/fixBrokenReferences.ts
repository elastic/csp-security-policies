import config from "config";
import axios from "axios";

const check: string = config.get("check_for_broken_references");

const cache: HttpCache = {};

function setCache(key: string, code: number) {
    cache[key] = code;
}

function getCache(key: string): number {
    return cache[key];
}

function logResponse(link: string, code: number, isFromCache: boolean) {
    const term = isFromCache ? "via cache" : "";
    console.log("Got", code, term, "for", link);
}

async function checkReference(link: string): Promise<boolean> {
    const code = getCache(link);
    if (!isNaN(code)) {
        logResponse(link, code, true);
        return code == 200;
    }
    return axios.head(link)
        .then(res => {
            logResponse(link, res.status, false);
            setCache(link, res.status);
            return res.status == 200;
        }).catch(err => {
            if (err.response) {
                setCache(link, err.response.status);
                logResponse(link, err.response.status, false);
            } else {
                // If we got here, it means that we failed to reach the server because of things that are IN OUR CONTROL
                // (e.g. timeout, socket reset)
                console.log(err);
                process.abort();
            }
            return false;
        })
}

function removeIfBroken(references: string[], i: number) {
}

export async function FixBrokenReferences(parsed_benchmarks: BenchmarkSchema[]): Promise<BenchmarkSchema[]> {
    if (!check)
        return parsed_benchmarks;
    for (const bench of parsed_benchmarks)
        for (const rule of bench.rules)
            for (let i = rule.references.length - 1; i >= 0; i--)
                // removeIfBroken(rule.references, i)
                if (!(await checkReference(rule.references[i])))
                    rule.references.splice(i, 1)
    return parsed_benchmarks
}