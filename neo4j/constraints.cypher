// ESCO Graph Constraints - Run First

CREATE CONSTRAINT occupation_uri IF NOT EXISTS FOR (o:Occupation) REQUIRE o.uri IS UNIQUE;
CREATE CONSTRAINT skill_uri IF NOT EXISTS FOR (s:Skill) REQUIRE s.uri IS UNIQUE;
CREATE CONSTRAINT skill_group_uri IF NOT EXISTS FOR (sg:SkillGroup) REQUIRE sg.uri IS UNIQUE;
CREATE CONSTRAINT isco_group_uri IF NOT EXISTS FOR (ig:ISCOGroup) REQUIRE ig.uri IS UNIQUE;
CREATE CONSTRAINT digital_skill_uri IF NOT EXISTS FOR (ds:DigitalSkill) REQUIRE ds.uri IS UNIQUE;
CREATE CONSTRAINT green_skill_uri IF NOT EXISTS FOR (gs:GreenSkill) REQUIRE gs.uri IS UNIQUE;
CREATE CONSTRAINT language_skill_uri IF NOT EXISTS FOR (ls:LanguageSkill) REQUIRE ls.uri IS UNIQUE;
CREATE CONSTRAINT transversal_skill_uri IF NOT EXISTS FOR (ts:TransversalSkill) REQUIRE ts.uri IS UNIQUE;
CREATE CONSTRAINT research_skill_uri IF NOT EXISTS FOR (rs:ResearchSkill) REQUIRE rs.uri IS UNIQUE;