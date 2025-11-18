// Coverage Gap Analysis
// Based on relationship insights: 129,004 relationships analyzed


// Identify opportunities for underutilized collections (language/transversal)
MATCH (occupation:Occupation)
WHERE occupation.preferredLabel =~ '(?i).*(translator|interpreter|linguist|language|communication).*'
OPTIONAL MATCH (occupation)-[:REQUIRES|OPTIONAL_SKILL]->(lang:LanguageSkill)
WITH occupation, count(lang) AS hasLanguageSkills
WHERE hasLanguageSkills = 0
RETURN occupation.preferredLabel AS occupation,
       occupation.description AS description,
       occupation.skillCount AS totalSkills,
       'Language Skills Gap' AS gapType
LIMIT 15;

// Similarly for transversal skills
MATCH (occupation:Occupation)
WHERE occupation.preferredLabel =~ '(?i).*(manager|leader|coordinator|supervisor).*'
OPTIONAL MATCH (occupation)-[:REQUIRES|OPTIONAL_SKILL]->(trans:TransversalSkill)
WITH occupation, count(trans) AS hasTransversalSkills
WHERE hasTransversalSkills <= 2  // Very few transversal skills
RETURN occupation.preferredLabel AS occupation,
       occupation.description AS description, 
       occupation.skillCount AS totalSkills,
       'Transversal Skills Gap' AS gapType
LIMIT 15;
