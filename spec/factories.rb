Factory.define :user do |f|
  f.name "User Name"
  f.initials "UN"
end

Factory.define :task do |f|
  f.title "Task"
  f.low_estimate "2"
  f.high_estimate "3"
end

Factory.define :sprint do |f|
  f.title "Sprint"
  f.start_date "2009-10-01"
  f.end_date "2009-10-31"
end
