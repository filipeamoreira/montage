# Description of the app


I’d like it if you could create a tool using Rails with which I would be able to upload a CSV file like the example attached (forgive the identical lines).

For each line in the CSV there are two photo URLs, the app should create a delayed job for each line that would create a montage of the two photos. It would also add the logo (also attached) as a watermark in the bottom right. There is an example of the montage attached also.

There should be a page available where I can export a csv file with the original URLs followed by the new montage url.

It should be possible for me to launch the app myself on heroku and be able to upload a file with thousands of lines, and spin up dozens of workers to speed through them.

If you think its more efficient to use Sinatra or something else lightweight rather than Rails, that is also fine, as long as its Ruby based, any gems you want to use is up to you.
