-- ------------------------------------------------------------------基本查询----------------------------------------------------------------------------------------
-- 录屏：spool c:sql语句.txt；
-- 清屏：host cls;
-- 显示当前管理员：show user;
-- 查询当前管理员下的表：
SELECT *
FROM tab;
-- 查询是否为空:desc table_name;
-- 显示行宽：show linesize;
-- 修改行宽：set linesize 150;
-- 设置列宽：col 列名 for a8;
-- 修改指令：ed
-- 执行修改后的指令:/
-- 查询员工信息（员工号 姓名 月薪 年薪 奖金 年收入）:
SELECT
  empno,
  ename,
  sal,
  sal * 12,
  comm,
  sal * 12 + nvl(comm, 0)
FROM emp;
-- sql中的null值：1.包含null的表达式也为null
-- 2.sql中的null != null
-- 查询员工奖金为null的员工：
SELECT *
FROM emp
WHERE comm IS NULL;
-- 为列起别名：
SELECT
  empno AS "员工号",
  ename    "姓名",
  sal      月薪,
  sal * 12,
  comm,
  sal * 12 + nvl(comm, 0)
FROM emp;
-- 一般使用 ename "姓名" ;
-- 去掉重复记录:distinct
SELECT DISTINCT job
FROM emp;
-- 把列与列，列与字符连接在一起 concat(列名或字符串,列名或字符串)
SELECT concat('hello', 'world')
FROM emp;
-- dual:伪表，伪列  DUMMY
-- 查询员工薪水：
SELECT ename || '的薪水是' || sal 薪水
FROM emp;
-- 停止录屏：spool off
-- ---------------------------------------------------------------------过滤-----------------------------------------------------------------------------------------
-- 使用where字句，将不满足条件的行过滤掉
-- 字符和日期写在单引号中，别名写在双引号中
-- 字符大小写敏感，日期格式敏感
-- oracle默认的日期格式  DD-MON-RR
-- 查询日期格式:
SELECT *
FROM v$nls_parameters;
-- 修改日期格式：
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-MM-dd';
--
-- 比较运算:
-- > >= < <= != <>  =赋值   :=符号赋值
-- between...and...在两个值之间，包含边界
-- in(set) 等于值列表中的一个
-- like 模糊查询
-- is null
--
-- between...and...在两个值之间，包含边界
-- 查询薪水在1000-2000之间的员工信息:
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;
-- in等于值列表中的一个
-- 查询部门编号是10,20的员工:
SELECT *
FROM emp
WHERE deptno IN (10, 20);
-- like模糊查询
-- %:任意长度的字符串：  _：任意的一个字符
-- 查询名称以S开头的员工
SELECT *
FROM emp
WHERE ename LIKE 'S%';
-- 查询名称是4个字符的员工
SELECT *
FROM emp
WHERE ename LIKE '____';
-- 查询名称中带有_下划线的员工信息
INSERT INTO emp (empno, ename, HIREDATE, sal, deptno) VALUES (1001, 'Tom_AB', '17-12月-80', 3000, 10);
SELECT *
FROM EMP;
SELECT *
FROM emp
WHERE ename LIKE '%\_%' ESCAPE '\';
-- 回滚
ROLLBACK; -- 回滚（使添加的ename ==Tom_AB的行失效）
-- Oracle会自动开启事务
--
-- 注意：
-- where 表达式1 and 表达式2 ,尽量将false的表达式写在前面
-- where 表达式1 or 表达式2 ,尽量将true的表达式写在前面前
--
-- --------------------------------------------------------------------------排序------------------------------------------------------------------------------------
-- 1，查询员工信息，按照月薪进行排序
SELECT *
FROM emp
ORDER BY sal; --（默认从小到大排序）
SELECT *
FROM emp
ORDER BY sal DESC; --（desc：从大到小排序）
-- 2，多个列排序
SELECT *
FROM emp
ORDER BY deptno, sal; --（首先将部门编号（deptno）排序，然后根据部门编号 将再从部门内将sal排序）
SELECT *
FROM emp
ORDER BY deptno, sal DESC;
SELECT *
FROM emp
ORDER BY deptno DESC, sal DESC; --（效果与<elect * from emp order by deptno,sal desc;>相同）；
-- 3，查询员工信息，按照奖金排序
SELECT *
FROM emp
ORDER BY comm; -- (从小到大，然后是null)
SELECT *
FROM emp
ORDER BY comm DESC; --（从大到小排序，null在前）
SELECT *
FROM emp
ORDER BY comm DESC NULLS LAST; --（从大到小排序，但null在最后）
-- ---------------------------------------------------------------函数--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1，单行函数
SELECT
  lower('Hello World')   "转小写",
  upper('Hello World')   "转大写",
  initcap('hello world') "首字母大写"
FROM dual;
--substr(a,b) 从a中第b位开始取
SELECT substr('Hello World', 3)
FROM dual; -- llo World
-- substr(a,b,c) 从a中第b位开始取，取c位
SELECT substr('hello word', 3, 2)
FROM dual; -- ll
--instr(a,b) 查找指定的字符串，从a中找b,如果找到了就返回下标，否则返回0
SELECT instr('hello word', 'r')
FROM dual; -- 9
--length 字符数   lengthb 字节数
SELECT
  length('Hello 啊World')  "字符数",
  lengthb('Hello啊 World') "字节数"
FROM dual;

--lpad 左填充 rpad 右填充
--abcd 变成10位   lpad（对那个字符串进行填充,填充到多少位,用哪些字符填充）
SELECT
  lpad('adcd', 10, '*') "左",
  rpad('abcd', 10, '*') "右"
FROM dual;
--trim 去掉前后指定的字符
SELECT trim('H' FROM 'Hello WordH')
FROM dual;

-- 2，数值函数
--四舍五入
SELECT
  round(45.926, 1)  "1",
  round(45.926, 2)  "2",
  round(45.962, 3)  "3",
  round(45.962, -1) "-1",
  round(45.962, -2) "-2"
FROM dual;
-- 截断
SELECT
  trunc(45.962, 1)  "1",
  trunc(45.962, 2)  "2",
  trunc(45.962, 3),
  trunc(45.962, -1) "-1",
  trunc(45.962, -2) "-2"
FROM dual;
-- 求余
SELECT mod(10, 3)
FROM dual;

-- 3,日期函数
-- 查询当前日期
SELECT sysdate FROM dual;
/*
日起计算:
    在日期上加上一个数字或是减去一个数字仍为日期
    两个日期相减返回的是两个日期之间相差的天数
    可以用数字除以24来向日期中加上或减去小时
    不允许日期+日期
 */
--昨天，今天，明天
SELECT sysdate-1 昨天,sysdate"今天",sysdate+1"明天"FROM dual;
--计算员工的工龄
SELECT ENAME"员工姓名",HIREDATE"入职时间",(sysdate-HIREDATE)"入职天数",(sysdate-HIREDATE)/7"入职周数",(sysdate-HIREDATE)/30"入职月数",(sysdate-HIREDATE)/365"入职年份" FROM EMP;
--两个日期不能够相加
SELECT sysdate+sysdate FROM dual;--[42000][975] ORA-00975: 不允许日期 + 日期

--months_between **月之后
SELECT ENAME,HIREDATE,(sysdate-HIREDATE)/31,months_between(sysdate,HIREDATE) FROM EMP;
--12月之后
SELECT add_months(sysdate,12)FROM dual;
--本月最后一天
SELECT last_day(sysdate)FROM dual;

--next day 指定日期的下一个日期
--从今天开始下一个周日
SELECT next_day(sysdate,'星期日')FROM dual;
--从今天开始下一个周一
SELECT next_day(sysdate,'星期一')FROM dual;

--
--
