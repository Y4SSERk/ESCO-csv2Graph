// Network Centrality Analysis
// Based on relationship insights: 129,004 relationships analyzed


// Find central skills in the occupation-skill network
MATCH (skill:Skill)
WITH skill, skill.occupationCount AS degree
WHERE degree >= 50  // Based on 90th percentile analysis
OPTIONAL MATCH (skill)-[:RELATED_TO]-(related:Skill)
WITH skill, degree, count(related) AS relatedCount
RETURN skill.preferredLabel AS centralSkill,
       degree AS occupationConnections,
       relatedCount AS skillConnections,
       skill.skillType AS type,
       (degree + relatedCount) AS totalCentrality
ORDER BY totalCentrality DESC
LIMIT 20;
