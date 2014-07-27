X_train <- read.table('train/X_train.txt', header=F)
y_train <- read.table('train/y_train.txt', header=F)
subject_train <- read.table('train/subject_train.txt', header=F)

X_test <- read.table('test/X_test.txt', header=F)
y_test <- read.table('test/y_test.txt', header=F)
subject_test <- read.table('test/subject_test.txt', header=F)

features <- read.table('features.txt', header=F)
activities <- read.table('activity_labels.txt', header=F)

y_train[y_train['V1'] == 1] = "walking"
y_train[y_train['V1'] == 2] = "waliking_upstairs"
y_train[y_train['V1'] == 3] = "waliking_downstairs"
y_train[y_train['V1'] == 4] = "sitting"
y_train[y_train['V1'] == 5] = "standing"
y_train[y_train['V1'] == 6] = "laying"

y_test[y_test['V1'] == 1] = "walking"
y_test[y_test['V1'] == 2] = "waliking_upstairs"
y_test[y_test['V1'] == 3] = "waliking_downstairs"
y_test[y_test['V1'] == 4] = "sitting"
y_test[y_test['V1'] == 5] = "standing"
y_test[y_test['V1'] == 6] = "laying"

names(subject_test) = "subject"
names(subject_train) = "subject"
names(X_train) = features$V2
names(X_test) = features$V2
names(y_test) = "activity"
names(y_train) = "activity"
int_cols <-append(grep('.*mean.*', names(X_test)), grep('.*std.*', names(X_test)))

X_train_clean <- X_train[int_cols]
X_test_clean <- X_test[int_cols]

test_df <- cbind(subject_test, y_test, X_test_clean)
train_df <- cbind(subject_train, y_train, X_train_clean)

tidy1_df <- rbind.data.frame(test_df, train_df)

write.table(tidy1_df, file="clean_set.csv")
test <- read.table("clean_set.csv")
df_an <- summaryBy(list(names(test)[3:81], c("subject","activity")), data=test, FUN=c(mean,var))

write.table(df_an, file="summary_set.csv")
