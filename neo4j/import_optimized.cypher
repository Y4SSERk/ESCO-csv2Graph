// ESCO Graph Optimized Import Script - Production Grade
// Use this script for large-scale imports with performance optimizations

// Step 1: Create Constraints (Run First - REQUIRED)
:source constraints.cypher;

// Step 2: Create Indexes (Run After Constraints)
:source indexes.cypher;

// Step 3: Import Occupation Nodes with batch optimization
:auto
USING PERIODIC COMMIT 10000
LOAD CSV WITH HEADERS FROM 'file:///nodes_occupations.csv' AS row
CREATE (o:Occupation {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    altLabels: apoc.convert.fromJsonList(row.altLabels),
    description: row.description,
    iscoGroup: row.iscoGroup,
    status: row.status,
    code: row.code,
    inScheme: row.inScheme,
    regulatedProfessionNote: row.regulatedProfessionNote,
    scopeNote: row.scopeNote
});

// Step 4: Import Skill Nodes with batch optimization
:auto
USING PERIODIC COMMIT 10000
LOAD CSV WITH HEADERS FROM 'file:///nodes_skills.csv' AS row
CREATE (s:Skill {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    altLabels: apoc.convert.fromJsonList(row.altLabels),
    description: row.description,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    status: row.status,
    code: row.code,
    inScheme: row.inScheme,
    scopeNote: row.scopeNote
});

// Step 5: Import Supporting Nodes
LOAD CSV WITH HEADERS FROM 'file:///nodes_skill_groups.csv' AS row
CREATE (sg:SkillGroup {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    altLabels: apoc.convert.fromJsonList(row.altLabels),
    description: row.description,
    code: row.code,
    inScheme: row.inScheme,
    scopeNote: row.scopeNote
});

LOAD CSV WITH HEADERS FROM 'file:///nodes_isco_groups.csv' AS row
CREATE (ig:ISCOGroup {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    code: row.code,
    description: row.description,
    inScheme: row.inScheme
});

// Step 6: Import Collection Skill Nodes
LOAD CSV WITH HEADERS FROM 'file:///nodes_digital_skills.csv' AS row
CREATE (ds:DigitalSkill {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    description: row.description,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    status: row.status,
    collection: row.collection,
    coverageLevel: row.coverageLevel,
    code: row.code
});

LOAD CSV WITH HEADERS FROM 'file:///nodes_green_skills.csv' AS row
CREATE (gs:GreenSkill {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    description: row.description,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    status: row.status,
    collection: row.collection,
    coverageLevel: row.coverageLevel,
    code: row.code
});

LOAD CSV WITH HEADERS FROM 'file:///nodes_language_skills.csv' AS row
CREATE (ls:LanguageSkill {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    description: row.description,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    status: row.status,
    collection: row.collection,
    coverageLevel: row.coverageLevel,
    isUnderutilized: toBoolean(row.isUnderutilized),
    code: row.code
});

LOAD CSV WITH HEADERS FROM 'file:///nodes_transversal_skills.csv' AS row
CREATE (ts:TransversalSkill {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    description: row.description,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    status: row.status,
    collection: row.collection,
    coverageLevel: row.coverageLevel,
    isUnderutilized: toBoolean(row.isUnderutilized),
    code: row.code
});

LOAD CSV WITH HEADERS FROM 'file:///nodes_research_skills.csv' AS row
CREATE (rs:ResearchSkill {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    description: row.description,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    status: row.status,
    collection: row.collection,
    coverageLevel: row.coverageLevel,
    code: row.code
});

LOAD CSV WITH HEADERS FROM 'file:///nodes_digcomp_skills.csv' AS row
CREATE (dcs:DigCompSkill {
    uri: row.`uri:ID`,
    preferredLabel: row.preferredLabel,
    description: row.description,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    status: row.status,
    collection: row.collection,
    coverageLevel: row.coverageLevel,
    code: row.code
});
