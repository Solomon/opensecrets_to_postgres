DROP TABLE candidates;

CREATE TABLE candidates(
  id bigserial primary key,
  cycle varchar(255),
  fec_cand_id varchar(255),
  cid varchar(255),
  first_last_party varchar(255),
  party varchar(255),
  dist_id_run_for varchar(255),
  dist_id_currently_held varchar(255),
  current_candidate varchar(255),
  cycle_candidate varchar(255),
  crpico varchar(255),
  recip_code varchar(255),
  nopacs varchar(255),
  raised_from_pacs integer,
  raised_from_individuals integer,
  raised_total integer,
  raised_unitemized integer
);

COPY candidates(cycle, fec_cand_id, cid, first_last_party, party, dist_id_run_for, dist_id_currently_held, current_candidate, cycle_candidate, crpico, recip_code, nopacs) 
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_cands.txt' 
WITH CSV QUOTE '|' DELIMITER ',';

DROP TABLE committees;

CREATE TABLE committees(
  id bigserial primary key,
  cycle varchar(255),
  committee_id varchar(255),
  pac_short varchar(255),
  affiliate varchar(255),
  ultorg varchar(255),
  recip_id varchar(255),
  recip_code varchar(255),
  fec_cand_id varchar(255),
  party varchar(255),
  prim_code varchar(255),
  source varchar(255),
  sensitive varchar(255),
  foreign_owned varchar(255),
  active integer
);

COPY committees(cycle, committee_id, pac_short, affiliate, ultorg, recip_id, recip_code, fec_cand_id, party, prim_code, source, sensitive, foreign_owned, active)
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_cmtes.txt' 
WITH CSV QUOTE '|' DELIMITER ',';

DROP TABLE individual_contributions;

CREATE TABLE individual_contributions(
  id bigserial primary key,
  cycle varchar(255),
  fec_trans_id varchar(255),
  contributor_id varchar(255),
  contributor_name varchar(255),
  recipient_id varchar(255),
  org_name varchar(255),
  ult_org varchar(255),
  real_code varchar(255),
  date timestamp,
  amount integer,
  street varchar(255),
  city varchar(255),
  state varchar(255),
  zip varchar(255),
  recip_code varchar(255),
  type varchar(255),
  committee_id varchar(255),
  other_id varchar(255),
  gender varchar(255),
  old_format_employer_occupation varchar(255),
  microfilm varchar(255),
  occupation varchar(255),
  employer varchar(255),
  source varchar(255)
);

-- The format for the old pre-2012 files has an extra field for the combined employer/occupation field.
COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_new_individual.txt'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_old_individual_aa'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_old_individual_ab'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_old_individual_ac'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_old_individual_ad'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_old_individual_ae'
WITH CSV QUOTE '|' DELIMITER ',';

DROP TABLE pacs;

CREATE TABLE pacs(
  id bigserial primary key,
  cycle varchar(255),
  fec_rec_no varchar(255),
  pac_id varchar(255),
  cid varchar(255),
  amount integer,
  date timestamp,
  real_code varchar(255),
  type varchar(255),
  di varchar(255),
  fec_cand_id varchar(255)
);

COPY pacs(cycle, fec_rec_no, pac_id, cid, amount, date, real_code, type, di, fec_cand_id)
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_pacs.txt' 
WITH CSV QUOTE '|' DELIMITER ',';

DROP TABLE pac_to_pacs;

CREATE TABLE pac_to_pacs(
  id bigserial primary key,
  cycle varchar(255),
  fec_rec_no varchar(255),
  filer_id varchar(255),
  donor_committee varchar(255),
  contrib_lend_trans varchar(255),
  city varchar(255),
  state varchar(255),
  zip varchar(255),
  fec_occ_emp varchar(255),
  prim_code varchar(255),
  date timestamp,
  amount decimal,
  recipient_id varchar(255),
  party varchar(255),
  other_id varchar(255),
  recip_code varchar(255),
  recip_prim_code varchar(255),
  amend varchar(255),
  report varchar(255),
  pg varchar(255),
  microfilm varchar(255),
  type varchar(255),
  real_code varchar(255),
  source varchar(255)
);

COPY pac_to_pacs(cycle, fec_rec_no, filer_id, donor_committee, contrib_lend_trans, city, state, zip, fec_occ_emp, prim_code, date, amount, recipient_id, party, other_id, recip_code, recip_prim_code, amend, report, pg, microfilm, type, real_code, source )
from '/Users/sik/Solomon/programming/campaign_finance_projects/campaign_finance_code/combined_pac_other.txt'
WITH CSV QUOTE '|' DELIMITER ',';

DROP TABLE industry_codes;

CREATE TABLE industry_codes(
  id bigserial primary key,
  category_code varchar(255),
  category_name varchar(255),
  industry_code varchar(255),
  industry_name varchar(255),
  sector varchar(255),
  sector_long varchar(255)
);

-- Line 443 extra column at end of line needs to be deleted
COPY industry_codes(category_code, category_name, industry_code, industry_name, sector, sector_long)
from '/Users/sik/Downloads/CRP_Categories.txt'
WITH CSV DELIMITER E'\t';


DROP TABLE politicians;

CREATE TABLE politicians(
  id bigserial primary key,
  cid varchar(255),
  name varchar(255)
);

INSERT INTO politicians(cid, name)(
  SELECT distinct on(cid) cid, left(first_last_party, -4)
  FROM candidates
);

DROP TABLE pac_records;

CREATE TABLE pac_records(
  id bigserial primary key,
  committee_id varchar(255),
  pac_short varchar(255),
  affiliate varchar(255),
  ultorg varchar(255),
  recip_id varchar(255),
  recip_code varchar(255),
  fec_cand_id varchar(255),
  party varchar(255),
  prim_code varchar(255),
  source varchar(255),
  sensitive varchar(255),
  foreign_owned varchar(255)
);

INSERT INTO pac_records(committee_id, pac_short, affiliate, ultorg, recip_id, recip_code, fec_cand_id, party, prim_code, source, sensitive, foreign_owned)(
  SELECT distinct on(committee_id)
    committee_id, pac_short, affiliate, ultorg, recip_id, recip_code, fec_cand_id, party, prim_code, source, sensitive, foreign_owned
  FROM committees
);

CREATE INDEX ON candidates (cid);
CREATE INDEX ON individual_contributions (recipient_id);

CREATE INDEX ON individual_contributions (real_code);
CREATE INDEX ON pacs (cid);
CREATE INDEX ON pacs (real_code);
CREATE INDEX ON industry_codes (category_code);

CREATE INDEX ON politicians (cid);
CREATE INDEX ON politicians (name);

CREATE INDEX ON individual_contributions (cycle);
CREATE INDEX ON pacs (cycle);
CREATE INDEX ON candidates (cycle);

CREATE INDEX ON pac_records (committee_id);

-- Denormalize candidates to show total raised for each candidate by election cycle

with candidate_individual_contributions as (
  SELECT c.id as candidate_id
  , SUM(i.amount) as total_individual
  FROM candidates c
  JOIN individual_contributions i ON i.recipient_id = c.cid AND i.cycle = c.cycle
  GROUP BY c.id
)

UPDATE candidates SET raised_from_individuals = candidate_individual_contributions.total_individual
FROM candidate_individual_contributions
WHERE candidate_individual_contributions.candidate_id = candidates.id;


with pac_contributions as (
  SELECT c.id as candidate_id
  , SUM(p.amount) as total_pac
  FROM candidates c
  JOIN pacs p ON p.cid = c.cid AND p.cycle = c.cycle
  WHERE p.type != '24A' AND p.type != '24N'
  GROUP BY c.id
)

UPDATE candidates SET raised_from_pacs = pac_contributions.total_pac
FROM pac_contributions
WHERE pac_contributions.candidate_id = candidates.id;

UPDATE candidates SET raised_total = COALESCE(raised_from_individuals, 0) + COALESCE(raised_from_pacs, 0);

