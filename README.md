# Simple Image Montage Tool

This is the description of the tool:

> I’d like it if you could create a tool using Rails with which I would be able to upload a CSV file like the example attached (forgive the identical lines).

> For each line in the CSV there are two photo URLs, the app should create a delayed job for each line that would create a montage of the two photos. It would also add the logo (also attached) as a watermark in the bottom right. There is an example of the montage attached also.

> There should be a page available where I can export a csv file with the original URLs followed by the new montage url.

> It should be possible for me to launch the app myself on heroku and be able to upload a file with thousands of lines, and spin up dozens of workers to speed through them.

> If you think its more efficient to use Sinatra or something else lightweight rather than Rails, that is also fine, as long as its Ruby based, any gems you want to use is up to you.

## How to run the app locally

1. Clone the app
2. Run: `bundle install`
3. Run: `bundle exec rake db:create db:migrate`
4. Run: `bundle exec foreman start`
5. Visit: `localhost:5000`
6. Load CSV file. A sample file can be found on `doc/csv_input.csv`

## How to run the app on Heroku

Due to the ephemeral nature of Heroku root file system, this app needs to be deployed with an ActiveStorage storage service set of something other than the default `:local`.
