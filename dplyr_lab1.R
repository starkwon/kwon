library(dplyr)
emp <- read.csv("emp.csv")
View(emp)

#1
emp %>% filter(job == "MANAGER")

#2
emp %>% select(empno,ename,sal)

#3
emp %>% select(-empno)

#4
emp %>% select(ename, sal)

#5
emp %>%
  group_by(job) %>%    
  summarise(n = n())

#6
emp %>% filter(sal <= 3000 & sal >= 1000)%>%
  select(ename,sal,deptno)

#7
emp %>% filter(job != "ANALYST")%>%
  select(ename, job, sal)

#8
emp %>% filter(job == "SALESMAN" | job == "ANALYST")%>%
  select(ename, job)

#9
emp %>%
  group_by(job) %>%
  summarise(sum_sal=sum(sal))

#10
emp %>% arrange(sal)

#11
emp %>% arrange(desc(sal))%>%
head(1)

#12
newemp = emp %>%
  mutate(salary = sal,          
         commrate = comm) %>%
  select(-sal, -comm)
data_frame(newemp)      

#13
emp %>%
  group_by(deptno) %>%    
  summarise(length(deptno))%>%
  tail(1) %>%
  select(deptno)

#14
emp %>%
mutate(enamelength = nchar(as.character(ename))) %>%
  arrange(enamelength)

#15
emp %>%
  filter(comm != "NA") %>% 
  summarise(n=n())


  