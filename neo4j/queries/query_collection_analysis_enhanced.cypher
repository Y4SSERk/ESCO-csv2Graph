// Collection Analysis Enhanced
// Based on relationship insights: 129,004 relationships analyzed


// Analyze collection skills across occupations with coverage insights
MATCH (occupation:Occupation)-[rel:REQUIRES|OPTIONAL_SKILL]->(skill:Skill)
WHERE skill.collections IS NOT NULL AND size(skill.collections) > 0
WITH occupation, skill, rel,
     [coll IN skill.collections | 
       CASE coll
         WHEN 'digital' THEN {name: 'Digital', coverage: '99.5%'}
         WHEN 'language' THEN {name: 'Language', coverage: '0.8%'}
         WHEN 'transversal' THEN {name: 'Transversal', coverage: '12.6%'}
         ELSE {name: coll, coverage: 'Unknown'}
       END
     ] AS collectionInfo
UNWIND collectionInfo AS coll
RETURN occupation.preferredLabel AS occupation,
       coll.name AS collection,
       coll.coverage AS coverage,
       count(skill) AS skillsInCollection,
       sum(CASE WHEN rel.isEssential THEN 1 ELSE 0 END) AS essentialSkills,
       avg(skill.occupationCount) AS avgSkillDemand
ORDER BY skillsInCollection DESC, collection
LIMIT 20;
