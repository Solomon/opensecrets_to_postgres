import os
import glob
import fileinput
import sys
import subprocess
from IPython.core.debugger import Tracer


class OrganizeFiles():
    def __init__(self, folder, unzip_name, new_prefix, header_file=None, unzip_year=None):
        self.folder = folder
        self.unzip_name = unzip_name
        self.new_prefix = new_prefix
        self.unzip_year = unzip_year
        self.header_file = header_file

    def unzip_committee_files(self):
        file_list = glob.glob('local_files/{}/*.zip'.format(self.folder))
        #file_list = glob.glob('local_files/{}/indiv90.zip'.format(self.folder))

        for f in file_list:
            year = f.split('.')[0][-2:]
            new_filename = self.new_prefix + year + '.txt'
            subprocess.call(['unzip', f])
            print 'hi'
            if self.unzip_year is None:
                current_name = self.unzip_name + '.txt'
            else:
                print self.unzip_name + year + '.txt'
                current_name = self.unzip_name + year + '.txt'
            print current_name
            os.rename(current_name, 'local_files/{}/'.format(self.folder) + new_filename)

    def header_string(self):
        header_path = 'local_files/{}/{}'.format(self.folder, self.header_file)
        with open(header_path, 'r') as f:
            first_line = f.readline()

        return first_line.replace(',','|')

    def fixed_format_line(self, line):
        # remove microsoft encoding
        decoded = line.decode('cp1252').encode('utf8')

        # remove apostraphes because csvkit seems to have problems with them:
        return decoded.replace('\'','')


    def add_cycle_to_files(self):
        file_list = glob.glob('local_files/{}/*.txt'.format(self.folder))
        #file_list = glob.glob('local_files/{}/individual_contributions90.txt'.format(self.folder))
        for f in file_list:
            year = f.split('.')[0][-2:]
            if int(year) < 30:
                year = '20' + year
            else:
                year = '19' + year

            for line in fileinput.input([f], inplace=True):
                fixed_line = self.fixed_format_line(line)
                if fileinput.isfirstline():
                    sys.stdout.write('CYCLE|{l}'.format(l=self.header_string()))
                    sys.stdout.write('{c}|{l}'.format(c=year, l=fixed_line))
                else:
                    sys.stdout.write('{c}|{l}'.format(c=year, l=fixed_line))

    def combine_converted_files(self):
        full_file_list = glob.glob('local_files/{}/*.txt'.format(self.folder))
        file_list = [f for f in full_file_list if "converted" in f]
        print file_list
        combined_filename = 'local_files/{}/combined_{}.csv'.format(self.folder, self.new_prefix)
        with open(combined_filename, 'w') as outfile:
            for fname in file_list:
                with open(fname) as infile:
                    for line in infile:
                        outfile.write(line)

    def import_files_to_postgres(self):
        full_file_list = glob.glob('local_files/{}/*.csv'.format(self.folder))
        file_list = [f for f in full_file_list if "converted" in f]

        for f in file_list:
            print f
            command = 'psql -c "COPY fec_individual_contributions FROM \'/Users/sik/Solomon/programming/campaign_finance_projects/opensecrets_to_postgres/{}\' with DELIMITER \',\' CSV HEADER" campaign_finance'.format(f)
            subprocess.call(command, shell=True)

    def check_format_and_convert(self):
        file_list = glob.glob('local_files/{}/*.txt'.format(self.folder))
        for f in file_list:
            print f
            year = f.split('.')[0][-2:]
            command = 'in2csv -d "|" -f csv -v local_files/{}/{}{}.txt > local_files/{}/converted{}.csv'\
                    .format(self.folder, self.new_prefix, year, self.folder, year)
            subprocess.call(command, shell=True)


    def run(self):
        print 'hik'
        #self.unzip_committee_files()
        #self.add_cycle_to_files()
        #self.check_format_and_convert()
        self.import_files_to_postgres()


if __name__ == "__main__":
    #a = OrganizeFiles(folder='fec_candidate_summary_files', unzip_name='weball', new_prefix='candidate_summary', unzip_year=True)
    a = OrganizeFiles(folder='fec_individual_contributions', unzip_name='itcont', new_prefix='individual_contributions', header_file='indiv_header_file.csv')
    a.run()

    # get the header file, and then run head -n 200 >> header_file.csv
    # Create the table for the new table, but don't insert
    # csvsql --db {db here} --no-constraints header_file.csv
    # sed -i '' 's/_unnamed//g' combined_individual_contributions.csv
    # COPY fec_individual_contributions FROM '/Users/sik/Solomon/programming/campaign_finance_projects/opensecrets_to_postgres/local_files/fec_individual_contributions/combined_individual_contributions.csv' DELIMITER ',' CSV;
    # COPY fec_individual_contributions FROM '/Users/sik/Solomon/programming/campaign_finance_projects/opensecrets_to_postgres/local_files/fec_individual_contributions/.csv' DELIMITER ',' CSV HEADER;
