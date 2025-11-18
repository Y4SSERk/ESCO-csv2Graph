// High Demand Skills
// Based on relationship insights: 129,004 relationships analyzed


// Find high-demand skills based on degree analysis (99th percentile = 109)
MATCH (skill:Skill)
WHERE skill.occupationCount >= 100
OPTIONAL MATCH (skill)-[:IN_COLLECTION]->(coll)
RETURN skill.preferredLabel AS skill,
       skill.occupationCount AS demand,
       skill.skillType AS type,
       skill.reuseLevel AS reuseLevel,
       coalesce(coll.collection, 'Standard') AS collection,
       skill.collections AS allCollections
ORDER BY demand DESC
LIMIT 15;
