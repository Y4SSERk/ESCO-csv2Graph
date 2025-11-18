// Career Pathways Enhanced
// Based on relationship insights: 129,004 relationships analyzed


// Find career pathways between occupations via shared skills (using degree insights)
MATCH (start:Occupation {preferredLabel: 'Software Developer'})
MATCH (target:Occupation {preferredLabel: 'Data Scientist'})
MATCH path = (start)-[:REQUIRES|OPTIONAL_SKILL]->(skill:Skill)<-[:REQUIRES|OPTIONAL_SKILL]-(target)
WITH start, target, skill, path
WHERE skill.occupationCount >= 5  // Filter by occupation count (based on 50th percentile)
RETURN start.preferredLabel AS startOccupation,
       target.preferredLabel AS targetOccupation,
       collect(DISTINCT skill.preferredLabel) AS sharedSkills,
       length(path) AS pathwayLength,
       avg(skill.occupationCount) AS avgSkillDemand
ORDER BY pathwayLength, size(sharedSkills) DESC
LIMIT 10;
