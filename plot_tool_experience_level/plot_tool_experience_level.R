INPUT_PATH = '..'
data <- read.csv(file.path(INPUT_PATH, 'Survey+Response_ModData_input.csv'))
data.exp <- data[, 27:31]
data.exp.orders <- c('None', 'A little', 'Confident', 'Expert')
data.exp.stat <- sapply(X=data.exp,FUN=table)
data.exp.stat <- t(data.exp.stat)
data.exp.stat <- data.exp.stat[, data.exp.orders]
tool <- rownames(data.exp.stat)
data.exp.stat <- cbind(tool, data.exp.stat)
write.csv(data.exp.stat, 'data.exp.stat.csv', row.names=FALSE)