interface BenchmarkMetadata {
    name: string;
    version: string;
}

interface CIS_EKS_Benchamrk_Schema {
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

interface CIS_K8S_Benchamrk_Schema {
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

type BenchmarksData = CIS_K8S_Benchamrk_Schema | CIS_EKS_Benchamrk_Schema;

interface BenchmarkSchema {
    filename: string;
    rules: RuleSchema[];
}

interface ExcelDataObject {
    name: string;
    data: unknown[];
}

interface RuleSchema {
    audit: string;
    benchmark: BenchmarkMetadata;
    default_value?: string;
    description: string;
    id: string;
    impact?: string;
    name: string;
    profile_applicability: string;
    rationale: string;
    references: string;
    // rego_rule_id: string;
    remediation: string;
    section: string;
    // tags: string[];
    // version: string;
}