
// Import Occupation-Skill Relationships with coverage tracking
LOAD CSV WITH HEADERS FROM 'file:///occupation_skills_sample.csv' AS row
MATCH (occupation:Occupation {uri: row.occupationUri})
MATCH (skill:Skill {uri: row.skillUri})
WITH occupation, skill, row
CALL apoc.do.when(
    row.relationType = 'essential',
    'CREATE (occupation)-[r:REQUIRES {relationType: row.relationType, skillType: row.skillType, isEssential: true, weight: 1.0}]->(skill) RETURN r',
    'CREATE (occupation)-[r:OPTIONAL_SKILL {relationType: row.relationType, skillType: row.skillType, isEssential: false, weight: 0.7}]->(skill) RETURN r',
    {occupation: occupation, skill: skill, row: row}
) YIELD value
RETURN count(*) AS relationships_created;

// Update occupation skill counts
MATCH (o:Occupation)
SET o.skillCount = size([(o)-[:REQUIRES|OPTIONAL_SKILL]->() | 1]),
    o.essentialSkillCount = size([(o)-[:REQUIRES]->() | 1]),
    o.optionalSkillCount = size([(o)-[:OPTIONAL_SKILL]->() | 1]);

// Update skill occupation counts  
MATCH (s:Skill)
SET s.occupationCount = size([()-[:REQUIRES|OPTIONAL_SKILL]->(s) | 1]),
    s.essentialOccupationCount = size([()-[:REQUIRES]->(s) | 1]);
