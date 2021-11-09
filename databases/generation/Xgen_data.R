



# The code segement below generates the data for the `Location` table
# There will be **1000** unique locations that the code segment will generate below

country_s        = c("UnitedStates", "Spain", "UnitedKingdom", "Germany", "France", "Canada", "Russia", "Ukraine", "Albania", "Italy")
state_province_s = c("NewYork", "NewJersey", "YorkShire", "Chanteau", "Champaigne", "Bordaeux", "Minnesota", "Illinois", "Ohio", "Washington")
city_s           = c("Chicago", "NewYork", "Milan", "Paris", "London", "Geneva", "Seattle", "SanFrancisco", "Sofia", "Moscow")

country        = c()
state_province = c()
city           = c()


for (c in country_s) {
  for (sp in state_province_s) {
    for (t in city_s) {
      country        = c(country, c)
      state_province = c(state_province, sp)
      city           = c(city, t)
    }    
  }
}

location_df = data.frame(country, state_province, city)

write.csv(location_df, file = "/Users/ivan/Documents/riwww/cs411/projdump/Xlocation.csv", row.names = TRUE)



# The code segment below generates data for the `CovidStatus` table
# There will be **2920** unique entries
# Note that the column 'PreviousTest' represents the number of days since the last test
# The maximum value of 'PreviousTest' is **365**.
# **1** is TRUE and **0** is FALSE

has_covid     = c()
previous_test = c()
test_negative = c()
test_inconcls = c()

for (hc in c(1, 0)) {
  for (tn in c(1, 0)) {
    for (ti in c(1, 0)) {
      for (d in 1:365) {
        has_covid = c(has_covid, hc)
        previous_test = c(previous_test, d)
        test_negative = c(test_negative, tn)
        test_inconcls = c(test_inconcls, ti)
      }      
    }
  }
}

CovidStatus_df = data.frame(has_covid, previous_test, test_negative, test_inconcls)

write.csv(CovidStatus_df, file = "/Users/ivan/Documents/riwww/cs411/projdump/Xcovid_status.csv", row.names = TRUE)


# The code segment below generates data for the `Risk` table.
# There will be **20** entries for this table since it only contains two columns.
# **1** is TRUE and **0** is FALSE

risk_level = c()
im_comp    = c()

for (rl in 0:9) {
  for (ic in c(1, 0)) {
    risk_level = c(risk_level, rl)
    im_comp    = c(im_comp, ic)
  }
}

risk_level_df = data.frame(risk_level, im_comp)

write.csv(risk_level_df, file = "/Users/ivan/Documents/riwww/cs411/projdump/Xrisk.csv", row.names = TRUE)


# The code sgement below generates the data for the WorkStatus table.
# There will be variable number of rows
# **1** is TRUE and **0** is FALSE

MIN_ITER = dim(location_df)[1]
work_type_s = c("construction", "technology", "hospital", "service", "labor", "homemaker", "finance", "consultency", "university", "law")
location_id = c()
work_type = c()
high_inter = c()
hrs_inter = c()

for (i in 1:MIN_ITER) {
  num_locations   = sample(1:10, 1, replace = TRUE)
  work_type_temp  = sample(work_type_s, 1, replace = TRUE)
  high_inter_temp = sample(c(1, 0), 1, replace = TRUE)
  hrs_inter_temp  = sample(1:24, 1, replace = TRUE)
  for (location in 1:num_locations) {
    location_id_temp = sample(1:MIN_ITER, 1, replace = FALSE)
    
    location_id = c(location_id, location_id_temp)
    work_type   = c(work_type, work_type_temp)
    high_inter  = c(high_inter, high_inter_temp)
    hrs_inter   = c(hrs_inter, hrs_inter_temp)
  }
}

WorkStatus_df = data.frame(location_id, work_type, high_inter, hrs_inter)

write.csv(WorkStatus_df, file = "/Users/ivan/Documents/riwww/cs411/projdump/Xworkstatus.csv", row.names = TRUE)


# The code segment below generates the data for the People table. 
# There will be *300000* entries for the People table.
N_people = 10000

first_name_s = c("Versace", "Armani", "Givenchy", "Vetements", "Maharishi", "Bape", "Burberry", "RalphLauren", "CanadaGoose", "Moncler")
last_name_s  = c("Sputnik", "theNorthFace", "GoldenGooseDeluxe", "yvesSaintLauren", "Balmain", "Fendi", "Prada", "Cartier", "Chanel", "Margiela")
gender_s = c("female", "male", "other")    #  Should only be these three types
email_s = c("fake@illinois.edu", "fake@gmail.com", "fake@hotmail.com", "pseudo@illinois.edu", "pseudo@email.edu", "pseudo@hotmail.com", "pseudo@verizon.net", "fake@sputnik.net", "real@email.com", "realReal@email.edu")
age_s = c(23:28)

risk_id = c()
status_id = c()
first_name = c()
last_name = c()
age = c()
gender = c()
email = c()


for (p in 1:N_people) {
  print(p)
  
  first_name = c(first_name, sample(first_name_s, 1, replace = TRUE))
  last_name  = c(last_name, sample(last_name_s, 1, replace = TRUE))
  age        = c(age, sample(1:100, 1, replace = TRUE))
  gender     = c(gender, sample(gender_s, 1, replace = TRUE))
  email      = c(email, sample(email_s, 1, replace = TRUE))
  risk_id    = c(risk_id, sample(1:(dim(risk_level_df)[1]), 1, replace = TRUE))
  status_id  = c(status_id, sample(1:(dim(CovidStatus_df)[1])), 1, replace = TRUE)
}

# for (fn in first_name_s) {
#   print(fn)
#   for (lm in last_name_s) {
#   print(lm)
#    for (a in age_s) {
#      for (g in gender_s) {
#        for (e in email_s) {
#          first_name = c(first_name, fn)
#          last_name  = c(last_name, lm)
#          age        = c(age, a)
#          gender     = c(gender, g)
#          email      = c(email, e)
#          risk_id = c(risk_id, sample(1:(dim(risk_level_df)[1]), 1, replace = TRUE))
#          status_id = c(status_id, sample(1:(dim(CovidStatus_df)[1])), 1, replace = TRUE)
#        }
#      }
#    } 
#   }
# }

people_df = data.frame(risk_id, status_id, first_name, last_name, age, gender, email)
write.csv(people_df, file = "/Users/ivan/Documents/riwww/cs411/projdump/Xpeople.csv", row.names = TRUE)




# The code below generates data for the PeopleWorkStatus table

people_id = c()
work_id   = c()
s1 = N_people
s2 = dim(WorkStatus_df)[1]
for (i in 1:12000) {
  people_id = c(people_id, sample(1:s1, 1, replace = TRUE))
  work_id   = c(work_id, sample(1:s2, 1, replace = TRUE))
}

people_work_status_df = data.frame(people_id, work_id)

write.csv(people_work_status_df, file = "/Users/ivan/Documents/riwww/cs411/projdump/Xpeople_work_status.csv", row.names = TRUE)



people_use_df = people_df[1:50000]
write.csv(people_use_df, file = "/Users/ivan/Documents/riwww/cs411/projdump/Xpeople_use.csv", row.names = TRUE)




































