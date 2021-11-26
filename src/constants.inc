%define 	EOL	        10
%define		READ		0
%define		SYS_READ	0
%define 	WRITE		1
%define		SYS_WRITE	1
%define 	STDOUT		1
%define		STDIN		0	
%define  	SYSCALL_EXIT	60

%define		NR_READ		0
%define		NR_WRITE	1
%define		NR_OPEN		2
%define		NR_CLOSE	3
%define		NR_LSEEK	8
%define		NR_CREATE	85
%define		NR_UNLINK	87

%define		O_CREAT		00000100q
%define		O_APPEND	00002000q
%define		O_RDONLY	000000q
%define		O_WRONLY	000001q
%define		O_RDWR		000002q

%define		S_IRUSR		00400q ; user read
%define		S_IWUSR		00200q ; user write

%define		NL		0xa;

