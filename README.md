## Get The OpenSecrets Data Into A Postgres Database

This repo is to help people easily (ok, semi-easily) get all the
opensecrets campaign contribution data off the internet and into a
postgres database. It took me a decent amount of time to automate lots
of the things you would otherwise need to do manually and learn about
the hard way. Hopefully this saves future researchers lots of time.

## The Easy Way

For those that care only about getting the data, I uploaded a `pg_dump`
of the database to S3.

You can download the database from this link:

[database dump](https://s3.amazonaws.com/campaign_finance/campaign_finance.dump)

Assuming you have postgres installed, run the following from your
terminal command line from the folder containing the file you just
downloaded:

`pg_restore -C -d campaign_finance campaign_finance.dump`

This will create a campaign finance database, and load it up with all
the data you need. The total size of the database without indexes is
about 5 gigs.

I'm going to be updating the `create_open_secrets_db_sql` file with
additional indexes as I find them necessary for my use case. If you want
to add these indexes to your version of the data, just check at the
bottom of that file, and copy the index commands after you psql into the
database.

## The Hard Way

This should work on any OSX or Linux systems, but won't work on
Windows.


### Get The Files

To start with, you need to go to [Open Secrets](http://www.opensecrets.org), create an account, and download
all the yearly data files. There are 5 database tables, with files for
every election season from 1990 through 2014. The five tables are
committees, candidates, individual contributions, pacs and pac to pacs.
You will need to download lots of files.

Take all those files and put them into the same folder, without renaming
them. Then copy the files from this repo into that folder.

### Combining The Yearly Files

Run the bash script as follows to clean and combine all the files for
easy upload into postgres.

`sh make_files.sh`

### Getting The Data Into Postgres

If you don't have postgres, you need to go download it and get it set
up.

Log into postgres and create a database named "campaign_finance".

Then `psql campaign_finance` to enter your new database.

Open up the `create_open_secrets_db.sql` file from this repo.

Paste the commands one by one into your terminal. You could probably
just run the whole file, and you would be ok, but I would recommend
running the commands one by one, to make sure that there aren't any
issues.

The most likely issue you might find is a formatting error somewhere in
the combined files while you are copying. Postgres will let you know the
line number of the error, so you can just open up the file in a text
editor, go directly to that line, and generally fix the formatting
error. Save the file, and then try the copy command again.

You will see that the old individual_contributions_combined file is
split into multiple parts. This is because the file is too large to fit
into memory on my computer, and had problems being copied into the
database.

I'm going to be adding indexes to this file as I use the data, and these
are optional. They make an already large database larger, so you can
decide which, if any, of these indexes you want to include for your
research. I'll sort them by how useful they are to me.

### Questions / Problems

Open up a github issue and I'll do my best to help.

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Credits

![open_secrets](http://assets.opensecrets.org/MyOS/img/opensecrets_databy250x88.gif)
