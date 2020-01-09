Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
