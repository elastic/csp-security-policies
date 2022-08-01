interface BenchmarkMetadata {
    name: string;
    version: string;
}

interface CIS_EKS_Benchmark_Schema {
    "section #": string;
    "recommendation #": string;
    "title": string;
    "description": string;
    "rationale statement": string;
    "impact statement": string;
    "remediation procedure": string;
    "audit procedure": string;
    "references": string;
}

interface CIS_K8S_Benchmark_Schema {
    "section #": string;
    "recommendation #": string;
    "title": string;
    "description": string;
    "rational statement": string;
    "impact statement": string;
    "remediation procedure": string;
    "audit procedure": string;
    "references": string;
}

type BenchmarksData = CIS_K8S_Benchmark_Schema | CIS_EKS_Benchmark_Schema;

interface SectionMetadata {
    "section #": string;
    "title": string;
}

interface BenchmarkSchema {
    filename: string;
    metadata: BenchmarkMetadata;
    rules: RuleSchema[];
}

interface ExcelDataObject {
    name: string;
    data: unknown[];
}

interface RuleSchema {
    audit: string;
    rule_number: string;
    benchmark: BenchmarkMetadata;
    default_value?: string;
    description: string;
    id: string;
    impact: string;
    name: string;
    profile_applicability: string;
    rationale: string;
    references: string[];
    // rego_rule_id: string;
    remediation: string;
    section: string;
    // tags: string[];
    // version: string;
}