package compliance.cis

# CIS 1.1.1
findings[x] {
    data.rules.cis_1_1_1
    x = data.compliance.cis.rules.cis_1_1_1.finding
}

# CIS 1.2.2
findings[x] {
    data.rules.cis_1_2_2
    x = data.compliance.cis.rules.cis_1_2_2.finding
}