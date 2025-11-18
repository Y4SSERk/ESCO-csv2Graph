// ESCO Graph Indexes - Run After Constraints

CREATE INDEX occupation_label IF NOT EXISTS FOR (o:Occupation) ON (o.preferredLabel);
CREATE INDEX occupation_isco IF NOT EXISTS FOR (o:Occupation) ON (o.iscoGroup);
CREATE INDEX occupation_code IF NOT EXISTS FOR (o:Occupation) ON (o.code);
CREATE INDEX occupation_skill_count IF NOT EXISTS FOR (o:Occupation) ON (o.skillCount);
CREATE INDEX occupation_isco_label IF NOT EXISTS FOR (o:Occupation) ON (o.iscoGroup, o.preferredLabel);
CREATE INDEX skill_label IF NOT EXISTS FOR (s:Skill) ON (s.preferredLabel);
CREATE INDEX skill_type IF NOT EXISTS FOR (s:Skill) ON (s.skillType);
CREATE INDEX skill_reuse_level IF NOT EXISTS FOR (s:Skill) ON (s.reuseLevel);
CREATE INDEX skill_occupation_count IF NOT EXISTS FOR (s:Skill) ON (s.occupationCount);
CREATE INDEX skill_type_label IF NOT EXISTS FOR (s:Skill) ON (s.skillType, s.preferredLabel);
CREATE INDEX skill_collections IF NOT EXISTS FOR (s:Skill) ON (s.collections);
CREATE INDEX skill_group_label IF NOT EXISTS FOR (sg:SkillGroup) ON (sg.preferredLabel);
CREATE INDEX skill_group_level IF NOT EXISTS FOR (sg:SkillGroup) ON (sg.hierarchyLevel);
CREATE INDEX isco_group_code IF NOT EXISTS FOR (ig:ISCOGroup) ON (ig.code);
CREATE INDEX isco_group_depth IF NOT EXISTS FOR (ig:ISCOGroup) ON (ig.depth);
CREATE INDEX rel_requires IF NOT EXISTS FOR ()-[r:REQUIRES]-() ON (r.relationType, r.isEssential);
CREATE INDEX rel_optional IF NOT EXISTS FOR ()-[r:OPTIONAL_SKILL]-() ON (r.relationType, r.isEssential);
CREATE INDEX rel_broader_skill IF NOT EXISTS FOR ()-[r:BROADER_THAN_SKILL]-() ON (r.hierarchyLevel, r.isDirect);
CREATE INDEX rel_broader_occupation IF NOT EXISTS FOR ()-[r:BROADER_THAN_OCCUPATION]-() ON (r.hierarchyLevel, r.isDirect);
CREATE INDEX rel_collection IF NOT EXISTS FOR ()-[r:IN_COLLECTION]-() ON (r.coverageLevel, r.isActiveInNetwork);
CREATE FULLTEXT INDEX occupation_search IF NOT EXISTS FOR (o:Occupation) ON EACH [o.preferredLabel, o.altLabels, o.description];
CREATE FULLTEXT INDEX skill_search IF NOT EXISTS FOR (s:Skill) ON EACH [s.preferredLabel, s.altLabels, s.description];