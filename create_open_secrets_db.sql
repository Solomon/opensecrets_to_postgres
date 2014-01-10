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
  nopacs varchar(255)
);

COPY candidates(cycle, fec_cand_id, cid, first_last_party, party, dist_id_run_for, dist_id_currently_held, current_candidate, cycle_candidate, crpico, recip_code, nopacs) 
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_cands.txt' 
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


-- line 40935 - changed to maersk - |2008|,|C00217471|,|Maersk Inc|,,|AP Moller-Mrsk|,|C00217471|,|PB|,||,,|T6200|,|WebEC|,|Y|,|1|,1
-- replace  with "ae" octal of 221 - :%s/\%o221/s/g
-- line 66750 |2012|,|C00423236|,|Sunovion Pharmaceuticals|,,|Sumitomo Chemicalÿ|,|C00423236|,|PB|,,| |,|H4300|,|Hvr06|,|N|,|0|,1
-- replace ÿ with "s" - octal value of 377  - :%s/\%o377/s/g


COPY committees(cycle, committee_id, pac_short, affiliate, ultorg, recip_id, recip_code, fec_cand_id, party, prim_code, source, sensitive, foreign_owned, active)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_cmtes.txt' 
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
  microfilm varchar(255),
  occupation varchar(255),
  employer varchar(255),
  source varchar(255)
);

-- NOT WORKING!! extra column(s?) in text document causing issues
COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/indivs14.txt' 
WITH CSV QUOTE '|' DELIMITER ',';

DROP TABLE pacs;

CREATE TABLE pacs(
  id bigserial primary key,
  cycle varchar(255),
  fec_rec_no varchar(255),
  pac_id varchar(255),
  cid varchar(255),
  amount decimal,
  date timestamp,
  real_code varchar(255),
  type varchar(255),
  di varchar(255),
  fec_cand_id varchar(255)
);

COPY pacs(cycle, fec_rec_no, pac_id, cid, amount, date, real_code, type, di, fec_cand_id)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_pacs.txt' 
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

-- error line 360463 |2008|,|0961630|,|C00238725|,|National Air Traffic Controllers Assn|,|Keeping Americas Promise PAC|,|Washington|,|DC|,|20007|,||,|LT100|,11/09/2007,2500.0,|C00409508|,|D|,|C00409508|,|PI|,|J2100|,|A|,|M12|,|P|,|27991006411|,|24K|,|LT100|,|PAC  |
--  octal 222 :%s/\%o222/'/g

-- error line 421780 |2008|,|4061627|,|C00099267|,|Democratic Party of North Carolina|,|North Carolina Democratic Party |,|Raleigh|,|NC|,|27603|,||,|Z5200|,11/07/2008,2180.0,|C00099267|,|D|,|C00165688|,|DP|,|Z5200|,|N|,|30G|,|P|,|28934751416|,|18G|,|Z5200|,|PAC  |
--  octal 226 :%s/\%o226//g

-- error line 520095 |2010|,|2504590|,|C00002766|,|United Food & Commercial Workers Union|,|DEMOCRATIC SENATORIAL CAMPAIGN  CO|,|WASHINGTON|,|DC|,|20003|,||,|LG100|,10/06/2010,15000.0,|C00042366|,|D|,|C00042366|,|DP|,|Z5200|,|N|,|12G|,|P|,|10931707731|,|24K|,|LG100|,|PAC  |
-- weird space character encoding between "campaign" and "co"
--  octal 240 :%s/\%o240//g

COPY pac_to_pac(cycle, fec_rec_no, filer_id, donor_committee, contrib_lend_trans, city, state, zip, fec_occ_emp, prim_code, date, amount, recipient_id, party, other_id, recip_code, recip_prim_code, amend, report, pg, microfilm, type, real_code, source )
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_pac_other.txt' 
WITH CSV QUOTE '|' DELIMITER ',';

