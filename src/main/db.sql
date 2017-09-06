-- ------------------------------------------------------------------基本查询----------------------------------------------------------------------------------------
-- 录屏：spool c:sql语句.txt；
-- 清屏：host cls;
-- 显示当前管理员：show user;
-- 查询当前管理员下的表：
select * from tab;
-- 查询是否为空:desc table_name;
-- 显示行宽：show linesize;
-- 修改行宽：set linesize 150;
-- 设置列宽：col 列名 for a8;
-- 修改指令：ed
-- 执行修改后的指令:/
-- 查询员工信息（员工号 姓名 月薪 年薪 奖金 年收入）:
select empno,ename,sal,sal*12,comm,sal*12+nvl(comm,0 ) from emp;
-- sql中的null值：1.包含null的表达式也为null
-- 2.sql中的null != null
-- 查询员工奖金为null的员工：
select * from emp where comm is null;
-- 为列起别名：
select empno as "员工号",ename "姓名",sal 月薪,sal*12,comm,sal*12+nvl(comm,0 ) from emp;
-- 一般使用 ename "姓名" ;
-- 去掉重复记录:distinct
select distinct job from emp;
-- 把列与列，列与字符连接在一起 concat(列名或字符串,列名或字符串)
select concat('hello','world') from emp;
-- dual:伪表，伪列  DUMMY
-- 查询员工薪水：
select ename||'的薪水是'||sal 薪水 from emp;
-- 停止录屏：spool off
-- ---------------------------------------------------------------------过滤-----------------------------------------------------------------------------------------
-- 使用where字句，将不满足条件的行过滤掉
-- 字符和日期写在单引号中，别名写在双引号中
-- 字符大小写敏感，日期格式敏感
-- oracle默认的日期格式  DD-MON-RR
-- 查询日期格式:
select * from v$nls_parameters;
-- 修改日期格式：
alter session set NLS_DATE_FORMAT='yyyy-MM-dd';
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
select * from emp where sal between 1000 and 2000;
-- in等于值列表中的一个
-- 查询部门编号是10,20的员工:
select * from emp where deptno in(10,20);
-- like模糊查询
-- %:任意长度的字符串：  _：任意的一个字符
-- 查询名称以S开头的员工
select * from emp where ename like 'S%';
-- 查询名称是4个字符的员工
select * from emp where ename like '____';
-- 查询名称中带有_下划线的员工信息
insert into emp(empno,ename,sal,deptno) values(1001,'Tom_AB',3000,10);
select * from emp where ename like '%\_%' escape '\';
-- 回滚
rollback;-- 回滚（使添加的ename ==Tom_AB的行失效）
-- Oracle会自动开启事务
--
-- 注意：
-- where 表达式1 and 表达式2 ,尽量将false的表达式写在前面
-- where 表达式1 or 表达式2 ,尽量将true的表达式写在前面前
--
-- --------------------------------------------------------------------------排序------------------------------------------------------------------------------------
-- 1，查询员工信息，按照月薪进行排序
select * from emp order by sal;--（默认从小到大排序）
select * from emp order by sal desc;--（desc：从大到小排序）
-- 2，多个列排序
select * from emp order by deptno,sal;--（首先将部门编号（deptno）排序，然后根据部门编号 将再从部门内将sal排序）
select * from emp order by deptno,sal desc;
select * from emp order by deptno desc,sal desc;--（效果与<elect * from emp order by deptno,sal desc;>相同）；
-- 3，查询员工信息，按照奖金排序
select * from emp order by comm;-- (从小到大，然后是null)
select * from emp order by comm desc;--（从大到小排序，null在前）
select * from emp order by comm desc nulls last;--（从大到小排序，但null在最后）
-- ---------------------------------------------------------------函数--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1，单行函数
select lower('Hello World') "转小写",upper('Hello World') "转大写",initcap('hello world') "首字母大写" from dual;
--
--substr(a,b) 从a中第b位开始取
select substr('Hello World',3) from dual;-- llo World
-- substr(a,b,c) 从a中第b位开始取，取c位
SELECT  substr('hello word',3,2)FROM dual;-- ll
--instr(a,b) 查找指定的字符串，从a中找b,如果找到了就返回下标，否则返回0
SELECT instr('hello word','r')FROM dual;-- 9
--length 字符数   lengthb 字节数
select length('Hello 啊World') "字符数",lengthb('Hello啊 World') "字节数" from dual;


--
--
