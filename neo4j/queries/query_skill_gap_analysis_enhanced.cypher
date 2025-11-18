// Skill Gap Analysis Enhanced
// Based on relationship insights: 129,004 relationships analyzed


// Identify missing skills for career transition with coverage awareness
MATCH (current:Occupation {preferredLabel: 'Marketing Manager'})
MATCH (target:Occupation {preferredLabel: 'Digital Marketing Specialist'})
MATCH (current)-[:REQUIRES]->(currentSkill:Skill)
MATCH (target)-[:REQUIRES]->(targetSkill:Skill)
WHERE NOT (current)-[:REQUIRES|OPTIONAL_SKILL]->(targetSkill)
WITH target, targetSkill,
     CASE 
       WHEN targetSkill.collections CONTAINS 'digital' THEN 'High Coverage'
       WHEN targetSkill.collections CONTAINS 'language' THEN 'Low Coverage' 
       ELSE 'Standard'
     END AS coverageCategory
RETURN target.preferredLabel AS targetOccupation,
       targetSkill.preferredLabel AS missingSkill,
       targetSkill.skillType AS skillType,
       coverageCategory,
       targetSkill.occupationCount AS marketDemand
ORDER BY marketDemand DESC, coverageCategory
LIMIT 15;
