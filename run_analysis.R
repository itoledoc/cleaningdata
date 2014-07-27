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

newnames <- sub('\\()','c', features$V2)
newnames <- sub('-','.', newnames)

names(X_train) = newnames
names(X_test) = newnames
names(y_test) = "activity"
names(y_train) = "activity"
int_cols <-append(grep('.*meanc', names(X_test)), grep('.*stdc', names(X_test)))

X_train_clean <- X_train[int_cols]
X_test_clean <- X_test[int_cols]

names(X_train_clean) <- sub('meanc','mean',names(X_train_clean))
names(X_train_clean) <- sub('stdc','std',names(X_train_clean))

names(X_test_clean) <- sub('meanc','mean',names(X_test_clean))
names(X_test_clean) <- sub('stdc','std',names(X_test_clean))

test_df <- cbind(subject_test, y_test, X_test_clean)
train_df <- cbind(subject_train, y_train, X_train_clean)

tidy1_df <- rbind.data.frame(test_df, train_df)
names(tidy1_df) <- sub('-','.',names(tidy1_df))

write.table(tidy1_df, file="clean_set.csv")

df_an <- summaryBy(list(names(tidy1_df)[3:81], c("subject","activity")), data=tidy1_df, FUN=c(mean,sd))

write.table(df_an, file="summary_set.csv")
