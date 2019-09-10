library(haven)
library(dplyr)

# Import data
train <- read_sas("Homework2_LR/insurance_t_bin.sas7bdat")
valid <- read_sas("Homework2_LR/insurance_v_bin.sas7bdat")

# Replacing missing values
sum(is.na(train)) # 4688
train[is.na(train)] <- "M"
sum(is.na(train)) # 0 — success!

# Investigating for seperation concerns: CASHBK and MMCRED pot. probs ----
for (name in colnames(train)){
  table <- table(train[, name], train$INS)
  print(name)
  print(table)
}
  
# Adjusting sep. concerns ----
table(train$CASHBK, train$INS)
table(train$MMCRED, train[,"INS"])

# Remove categories with 0 counts, removes only 3 observations
# CASHBK Cat. 2 has 0 instances of INS 1, 2 instances of INS 0
# MMCRED Cat. 5 has 0 instances of INS 1, 1 instance of INS 0
train_adj <- filter(train, CASHBK != 2, MMCRED != 5)

write.csv(train_adj, 'train_adj.csv')


train$BRANCH
