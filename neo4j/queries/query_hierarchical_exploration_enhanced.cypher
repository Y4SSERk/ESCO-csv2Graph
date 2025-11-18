// Hierarchical Exploration Enhanced
// Based on relationship insights: 129,004 relationships analyzed


// Explore occupation hierarchy and required skills with degree filtering
MATCH (root:ISCOGroup {code: '25'})  // ICT professionals
MATCH path = (root)-[:BROADER_THAN_OCCUPATION*0..3]->(occupation:Occupation)
MATCH (occupation)-[rel:REQUIRES]->(skill:Skill)
WHERE rel.isEssential = true
  AND occupation.skillCount >= 20  // Filter by skill count (based on analysis)
  AND skill.occupationCount >= 10  // Filter by occupation count
RETURN occupation.preferredLabel AS occupation,
       skill.preferredLabel AS essentialSkill,
       skill.skillType AS skillType,
       length(path) AS hierarchyLevel,
       occupation.skillCount AS totalSkills,
       skill.occupationCount AS skillPopularity
ORDER BY hierarchyLevel, skillPopularity DESC
LIMIT 20;
