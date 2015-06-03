import os
import glob
import fileinput
import sys
import subprocess
from IPython.core.debugger import Tracer


class OrganizeFiles():
    def __init__(self, folder, unzip_name, new_prefix, unzip_year=None):
        self.folder = folder
        self.unzip_name = unzip_name
        self.new_prefix = new_prefix
        self.unzip_year = unzip_year

    def unzip_committee_files(self):
        file_list = glob.glob('local_files/{}/*.zip'.format(self.folder))

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

    def add_cycle_to_files(self):
        file_list = glob.glob('local_files/{}/*.txt'.format(self.folder))
        for f in file_list:
            year = f.split('.')[0][-2:]
            if int(year) < 30:
                year = '20' + year
            else:
                year = '19' + year

            for line in fileinput.input([f], inplace=True):
                sys.stdout.write('{c}|{l}'.format(c=year, l=line))

    def combine_committee_files(self):
        file_list = glob.glob('local_files/{}/*.txt'.format(self.folder))
        combined_filename = 'local_files/{}/combined_{}.csv'.format(self.folder, self.new_prefix)
        with open(combined_filename, 'w') as outfile:
            for fname in file_list:
                with open(fname) as infile:
                    for line in infile:
                        outfile.write(line)

    def run(self):
        print 'hik'
        self.unzip_committee_files()
        self.add_cycle_to_files()
        self.combine_committee_files()


if __name__ == "__main__":
    a = OrganizeFiles(folder='fec_candidate_summary_files', unzip_name='weball', new_prefix='candidate_summary', unzip_year=True)
    a.run()
