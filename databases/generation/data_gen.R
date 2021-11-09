# The code segment below generates pseudo data


first_name_s = c("Versace", "Armani", "Givenchy", "Vetements", "Maharishi", "Bape", "Burberry", "RalphLauren", "CanadaGoose", "Moncler")
last_name_s  = c("Sputnik", "theNorthFace", "GoldenGooseDeluxe", "yvesSaintLauren", "Balmain", "Fendi", "Prada", "Cartier", "Chanel", "Margiela")
#    age_s <- generate random int
gender_s = c("female", "male", "other")    #  Should only be these three types
email_s = c("fake@illinois.edu", "fake@gmail.com", "fake@hotmail.com", "pseudo@illinois.edu", "pseudo@email.edu", "pseudo@hotmail.com", "pseudo@verizon.net", "fake@sputnik.net", "real@email.com", "realReal@email.edu")

work_type_s = c("construction", "technology", "hospital", "service", "labor", "homemaker", "finance", "consultency", "university", "law")    #  Should only be limited options, each work type has a risk factor associated with it
#    interaction_s <- generate random int between 0 and 9 (inclusive)
#    daily_hours_s <- generate random int between 0 and 9 (inclusive)

country_s = c("UnitedStates", "Spain", "UnitedKingdom", "Germany", "France", "Canada", "Russia", "Ukraine", "Albania", "Italy")
state_province_s = c("NewYork", "NewJersey", "YorkShire", "Chanteau", "Champaigne", "Bordaeux", "Minnesota", "Illinois", "Ohio", "Washington")
city_s = c("Chicago", "NewYork", "Milan", "Paris", "London", "Geneva", "Seattle", "SanFrancisco", "Sofia", "Moscow")

#    risk_level_s <- generate random int between 0 and 9 (inclusive)
#    im_comp_s <- generate boolean

#    has_covid_s <- generate boolean
#    prev_test_s <- generate random int between 0 and 31 (inclusive) if *31* then it incorporates 31+
#    test_neg_s <- generate boolean
#    test_inconcls_s <- generate boolean


N_fake_people = 2500

first_name    = c()
last_name     = c()
age           = c()
gender        = c()
email         = c()
work_type     = c()
interaction   = c()
daily_hours   = c()
country       = c()
state_prov    = c()
city          = c()
risk_level    = c()
im_comp       = c()
has_covid     = c()
prev_test     = c()
test_neg      = c()
test_inconcls = c()

for (i in 1:N_fake_people) {
  sample_first_name  = sample(1:length(first_name_s), 1, replace = TRUE)
  first_name         = c(first_name, first_name_s[sample_first_name])
  
  sample_last_name   = sample(1:length(last_name_s), 1, replace = TRUE)
  last_name          = c(last_name, last_name_s[sample_last_name])
  
  sample_age         = sample(1:100, 1, replace = TRUE)
  age                = c(age, sample_age)
  
  sample_gender      = sample(1:length(gender_s), 1, replace = TRUE)
  gender             = c(gender, gender_s[sample_gender])
  
  sample_email       = sample(1:length(email_s), 1, replace = TRUE)
  email              = c(email, email_s[sample_email])
  
  sample_work_type   = sample(1:length(work_type_s), 1, replace = TRUE)
  work_type          = c(work_type, work_type_s[sample_work_type])
  
  sample_interaction = sample(1:9, 1, replace = TRUE)
  interaction        = c(interaction, sample_interaction)
  
  sample_daily_hours = sample(0:24, 1, replace = TRUE)
  daily_hours        = c(daily_hours, sample_daily_hours)
  
  sample_country     = sample(1:length(country_s), 1, replace = TRUE)
  country            = c(country, country_s[sample_country])
  
  sample_state_prov  = sample(1:length(state_province_s), 1, replace = TRUE)
  state_prov         = c(state_prov, state_province_s[sample_state_prov])
  
  sample_city        = sample(1:length(city_s), 1, replace = TRUE)
  city               = c(city, city_s[sample_city])
  
  sample_risk_level  = sample(1:9, 1, replace = TRUE)
  risk_level         = c(risk_level, sample_risk_level)
  
  sample_im_comp     = sample(c(TRUE, FALSE), 1, replace = TRUE)
  im_comp            = c(im_comp, sample_im_comp)
  
  sample_has_covid   = sample(c(TRUE, FALSE), 1, replace = TRUE)
  has_covid          = c(has_covid, sample_has_covid)
    
  sample_prev_test   = sample(1:31, 1, replace = TRUE)
  prev_test          = c(prev_test, sample_prev_test)  
  
  sample_test_neg    = sample(c(TRUE, FALSE), 1, replace = TRUE)
  test_neg           = c(test_neg, sample_test_neg)
  
  sample_inconcls    = sample(c(TRUE, FALSE), 1, replace = TRUE)
  test_inconcls      = c(test_inconcls, sample_inconcls)
}

df <- data.frame(first_name, last_name, age, gender, email, work_type, interaction, daily_hours, country, state_prov, city, risk_level, im_comp, has_covid, prev_test, test_neg, test_inconcls)
location_df <- data.frame(country, state_prov, city)
write.csv(df, file = "/Users/ivan/Documents/riwww/cs411/projdump/pseudo_data.csv", row.names = TRUE)
write.csv(location_df, file = "/Users/ivan/Documents/riwww/cs411/projdump/plzwork.csv", row.names = TRUE)



country_s = c("UnitedStates", "Spain", "UnitedKingdom", "Germany", "France", "Canada", "Russia", "Ukraine", "Albania", "Italy")
state_province_s = c("NewYork", "NewJersey", "YorkShire", "Chanteau", "Champaigne", "Bordaeux", "Minnesota", "Illinois", "Ohio", "Washington")
city_s = c("Chicago", "NewYork", "Milan", "Paris", "London", "Geneva", "Seattle", "SanFrancisco", "Sofia", "Moscow")

for (c in country_s) {
  for (sp in state_prov) {
    for (t in city_s) {
      
    }
    
  }
}

