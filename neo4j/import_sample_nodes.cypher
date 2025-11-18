
// Import Sample Occupation Nodes with pre-computed counts
LOAD CSV WITH HEADERS FROM 'file:///occupations_sample.csv' AS row
CREATE (o:Occupation {
    uri: row.conceptUri,
    preferredLabel: row.preferredLabel,
    altLabels: CASE WHEN row.altLabels IS NOT NULL THEN split(replace(replace(row.altLabels, '"', ''), '[', ''), ',') ELSE [] END,
    description: row.description,
    iscoGroup: row.iscoGroup,
    status: row.status,
    code: row.code,
    inScheme: row.inScheme,
    regulatedProfessionNote: row.regulatedProfessionNote,
    scopeNote: row.scopeNote,
    skillCount: 0,  // Will be updated after relationships
    essentialSkillCount: 0,
    optionalSkillCount: 0
});

// Import Sample Skill Nodes with collection awareness
LOAD CSV WITH HEADERS FROM 'file:///skills_sample.csv' AS row
CREATE (s:Skill {
    uri: row.conceptUri,
    preferredLabel: row.preferredLabel,
    altLabels: CASE WHEN row.altLabels IS NOT NULL THEN split(replace(replace(row.altLabels, '"', ''), '[', ''), ',') ELSE [] END,
    description: row.description,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    status: row.status,
    code: row.code,
    inScheme: row.inScheme,
    scopeNote: row.scopeNote,
    occupationCount: 0,  // Will be updated after relationships
    essentialOccupationCount: 0,
    collections: []  // Will be populated based on collection membership
});

// Import Sample SkillGroup Nodes
LOAD CSV WITH HEADERS FROM 'file:///skill_groups_sample.csv' AS row
CREATE (sg:SkillGroup {
    uri: row.conceptUri,
    preferredLabel: row.preferredLabel,
    altLabels: CASE WHEN row.altLabels IS NOT NULL THEN split(replace(replace(row.altLabels, '"', ''), '[', ''), ',') ELSE [] END,
    description: row.description,
    code: row.code,
    inScheme: row.inScheme,
    scopeNote: row.scopeNote,
    hierarchyLevel: 0,  // Will be calculated from hierarchy
    childCount: 0
});
