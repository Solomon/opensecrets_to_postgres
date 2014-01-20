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


-- ga in vim to get the octal of the strange character
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
  old_format_employer_occupation varchar(255),
  microfilm varchar(255),
  occupation varchar(255),
  employer varchar(255),
  source varchar(255)
);

-- line 99757 |2012|,|1031120130013541703|,|h1001345604 |,|SHLESINGER, GERALD J|,|N00009818|,|Della Spiga Caf|,||,|G2900|,09/16/2012,1500,||,|LAS VEGAS|,|NV|,|89117|,|DL|,|15J|,|C00325738|,,|M|,,|PRESIDENT|,|DELLA SPIGA CAFE-FORUM SHOPS AT CAESA|,|Name |
-- replace   with "e" - octal value of 202 - :%s/\%o202/s/g
-- line 862848 weird space encoding |2012|,|4021020121150746444|,|i30032354081|,|BARAI, BHARAT|,|N00003878|,|Premier Oncology Hematology Assoc|,||,|H1130|,12/09/2011,500,|9903 Twin Creek Blvd|,|MUNSTER|,|IN|,|46321|,|RL|,|15 |,|C00500173|,,|M|,|12970307857|,|PHYSICIAN|,|PREMIER ONCOLOGY HEMATOLOGY ASSOCIATES|,|Name |
-- replace with " " - octal value of 240 - :%s/\%o240/ /g
-- line 894151 |2012|,|4020720131180961497|,|k0001118348 |,|NAEGER, HENRI MR JR|,|C00003418|,|Maersk Line|,|AP Moller-Mrsk|,|T6200|,10/12/2012,500,|2112 Old Indian Rd|,|RICHMOND|,|VA|,|23235|,|RP|,|15 |,|C00003418|,,|M|,|13960745377|,|U. S. MERCHANT MARINE|,|MAERSK LINE LIMITED|,|WEBWH|
-- replace  with "ae" - octal value of 221 - :%s/\%o221/ae/g
-- line 937930 |2012|,|4021020121150746530|,|m0001325952 |,|SHREWSBURY, RONDA|,|N00003878|,|Realamerica Development|,||,|Y4000|,11/28/2011,1000,|8038 Dean Roadÿ|,|INDIANAPOLIS|,|IN|,|46240|,|RL|,|15 |,|C00500173|,,|F|,|12970307885|,|Owner|,|RealAmerica Development|,|     |
-- replace ÿ with "s" - octal value of 377 - :%s/\%o377/s/g
-- line 2090571 |2012|,|4082820121161661910|,|m0001631653 |,|THORNHILL, DARRELL|,|C00494740|,|Ghirardelli Chocolate Co|,|Chocoladefabriken Lindt & Sprngli|,|Y4000|,07/07/2012,500,|28865 Bay Heights Rd|,|HAYWARD|,|CA|,|94542|,|DP|,|15 |,|C00494740|,,|M|,|12952687389|,|SAFETY/SECURITY MANAGER|,|GHIRARDELLI CHOCOLATE CO.|,|     |
-- replace  with "e" - octal value of 201 - :%s/\%o201/e/g
-- line 3258505 |2012|,|4121220121174569386|,|h1001325955A|,|COOK, QUARRIER B MRS|,|C00193433|,||,||,|J7400|,10/21/2012,1500,|1085 Camino MaÝana|,|SANTA FE|,|NM|,|87501|,|PI|,|15 |,|C00193433|,,|F|,|12940795257|,|RETIRED|,|RETIRED|,|P/PAC|
-- replace Ý with "e" - octal value of 335 - :%s/\%o335/Y/g

-- The format for the old pre-2012 files has an extra field for the combined employer/occupation field.
COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_new_individual.txt'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_old_individual_aa'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_old_individual_ab'
WITH CSV QUOTE '|' DELIMITER ',';

--Line 3383849 - join together|2010|,|0447954|,|i3003115759 |,|GROGG, STANLEY E|,|N00005601|,|OSU Center for Health Sciences
--|,|Oklahoma State University|,|H1100|,06/23/2009,500,||,|TULSA|,|OK|,|74105|,|RW|,|15 |,|C00409888|,||,|M|,|OSU-CHS/PHYSICIAN|,|29020303024|,||,||,|I/Rpt|
-- Line 3188803 join together|2010|,|0100443|,|i3003114485 |,|GOELZER, DANIEL L MR|,|C00003418|,|Public Company Accounting Oversight Bd
-- |,||,|X4000|,03/10/2009,1000,|5941 Searl Terrace|,|BETHESDA|,|MD|,|20816|,|RP|,|15 |,|C00003418|,||,|M|,|P.C.A.O.B./ATTORNEY|,|29992007891|,|Attorney|,|PCAOB|,|webDM|
-- line 3737255

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_old_individual_ac'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_old_individual_ad'
WITH CSV QUOTE '|' DELIMITER ',';

COPY individual_contributions(cycle, fec_trans_id, contributor_id, contributor_name, recipient_id, org_name, ult_org, real_code, date, amount, street, city, state, zip, recip_code, type, committee_id, other_id, gender, old_format_employer_occupation, microfilm, occupation, employer, source)
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_old_individual_ae'
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

COPY pac_to_pacs(cycle, fec_rec_no, filer_id, donor_committee, contrib_lend_trans, city, state, zip, fec_occ_emp, prim_code, date, amount, recipient_id, party, other_id, recip_code, recip_prim_code, amend, report, pg, microfilm, type, real_code, source )
from '/Users/sik/Solomon/campaign_finance/opensecrets_data/combined/campaign_finance/combined_pac_other.txt' 
WITH CSV QUOTE '|' DELIMITER ',';

