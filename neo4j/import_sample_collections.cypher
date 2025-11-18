
// Create collection-specific nodes for digital skills
LOAD CSV WITH HEADERS FROM 'file:///digitalSkillsCollection_en.csv' AS row
WITH row LIMIT 50  // Sample for testing
MATCH (s:Skill {uri: row.conceptUri})
CREATE (ds:DigitalSkill {
    uri: row.conceptUri,
    preferredLabel: row.preferredLabel,
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    description: row.description,
    collection: 'digital',
    digCompArea: 'To be mapped',  // Would come from DigComp mapping
    coverageLevel: 'high'
})
CREATE (s)-[:IN_COLLECTION {coverageLevel: 'high', isActiveInNetwork: true}]->(ds);

// Create collection-specific nodes for language skills  
LOAD CSV WITH HEADERS FROM 'file:///languageSkillsCollection_en.csv' AS row
WITH row LIMIT 20  // Smaller sample for low coverage testing
MATCH (s:Skill {uri: row.conceptUri})
CREATE (ls:LanguageSkill {
    uri: row.conceptUri,
    preferredLabel: row.preferredLabel, 
    skillType: row.skillType,
    reuseLevel: row.reuseLevel,
    description: row.description,
    collection: 'language',
    languageFamily: 'To be mapped',
    coverageLevel: 'low',
    isUnderutilized: true
})
CREATE (s)-[:IN_COLLECTION {coverageLevel: 'low', isActiveInNetwork: false}]->(ls);

// Update collections array on base Skill nodes
MATCH (s:Skill)-[:IN_COLLECTION]->(coll)
WITH s, collect(coll.collection) AS colls
SET s.collections = colls;
