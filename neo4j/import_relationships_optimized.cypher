// ESCO Graph Relationships Import - Optimized for Production
// Run after nodes have been imported

// Occupation-Skill Relationships with batch optimization
:auto
USING PERIODIC COMMIT 5000
LOAD CSV WITH HEADERS FROM 'file:///relationships_occupation_skill.csv' AS row
MATCH (occupation:Occupation {uri: row.`:START_ID`})
MATCH (skill:Skill {uri: row.`:END_ID`})
CREATE (occupation)-[r:REQUIRES]->(skill)
SET r.relationType = row.relationType,
    r.skillType = row.skillType,
    r.isEssential = toBoolean(row.isEssential),
    r.weight = toFloat(row.weight);

// Skill-Skill Relationships
:auto
USING PERIODIC COMMIT 10000
LOAD CSV WITH HEADERS FROM 'file:///relationships_skill_skill.csv' AS row
MATCH (skill1:Skill {uri: row.`:START_ID`})
MATCH (skill2:Skill {uri: row.`:END_ID`})
CREATE (skill1)-[r:HAS_PREREQUISITE]->(skill2)
SET r.relationType = row.relationType,
    r.isStrong = toBoolean(row.isStrong);

// Hierarchy Relationships
:auto
USING PERIODIC COMMIT 10000
LOAD CSV WITH HEADERS FROM 'file:///relationships_hierarchy.csv' AS row
MATCH (source {uri: row.`:START_ID`})
MATCH (target {uri: row.`:END_ID`})
CREATE (source)-[r:BROADER_THAN]->(target)
SET r.sourceType = row.sourceType,
    r.targetType = row.targetType,
    r.isDirect = toBoolean(row.isDirect),
    r.hierarchyLevel = toInteger(row.hierarchyLevel);

// Collection Membership Relationships
:auto
USING PERIODIC COMMIT 10000
LOAD CSV WITH HEADERS FROM 'file:///relationships_collections.csv' AS row
MATCH (skill:Skill {uri: row.`:START_ID`})
MATCH (collection {uri: row.`:END_ID`})
CREATE (skill)-[r:IN_COLLECTION]->(collection)
SET r.collection = row.collection,
    r.coverageLevel = row.coverageLevel,
    r.isActiveInNetwork = toBoolean(row.isActiveInNetwork);

// Create collection relationships for matching skills
MATCH (s:Skill), (ds:DigitalSkill) WHERE s.uri = ds.uri CREATE (s)-[:IN_COLLECTION {coverageLevel: 'high'}]->(ds);
MATCH (s:Skill), (gs:GreenSkill) WHERE s.uri = gs.uri CREATE (s)-[:IN_COLLECTION {coverageLevel: 'high'}]->(gs);
MATCH (s:Skill), (ls:LanguageSkill) WHERE s.uri = ls.uri CREATE (s)-[:IN_COLLECTION {coverageLevel: 'low'}]->(ls);
MATCH (s:Skill), (ts:TransversalSkill) WHERE s.uri = ts.uri CREATE (s)-[:IN_COLLECTION {coverageLevel: 'low'}]->(ts);
MATCH (s:Skill), (rs:ResearchSkill) WHERE s.uri = rs.uri CREATE (s)-[:IN_COLLECTION {coverageLevel: 'medium'}]->(rs);
MATCH (s:Skill), (dcs:DigCompSkill) WHERE s.uri = dcs.uri CREATE (s)-[:IN_COLLECTION {coverageLevel: 'high'}]->(dcs);
