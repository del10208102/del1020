module beep_music  (
//输入与输出信号定义
input              clk  ,
input              rst_n,

output             beep
);
//中间信号定义
reg     [16:0]     cnt0    ;       //产生PWM的计数器
wire               add_cnt0;
wire               end_cnt0;

reg     [7:0]      cnt1    ;      //每个音符持续时间的计数器
wire               add_cnt1;
wire               end_cnt1;

reg     [10:0]      cnt2    ;     //共2^n个音节
wire               add_cnt2;
wire               end_cnt2;

reg     [16:0]     pre_set ;    //存放每个音节的频率在系统中的时钟个数

//每个音符对应的系统周期计数
localparam              M1=95602,           //1
                        M11=90253,          //1#
	                M2=85178,           //2
			M21=80386,          //2#
	                M3=75872,           //3
	                M4=71633,           //4
			M41=67568,          //4#
	                M5=63775,           //5
			M51=60168,          //5#
	                M6=56818,           //6
			M61=53648,          //6#
	                M7=50607,           //7
                        //high key
			H1=47801,           //1
			H11=45086,           //1#
			H2=42553,           //2
			H21=40161,           //2#
			H3=37936,           //3
			H4=35791,           //4
			H41=33784,           //4#
			H5=31888,           //5
			H51=30102,           //5#
			H6=28409,          //6
			H61=26810,          //6#
			H7=25303,          //7

			//更高音
	                HH1=23883,
	                HH2=22543,

			//low key
			D5=127551,          //5
			D51=120482,         //5#
			D6=113636,          //6
			D61=107296,         //6#
			D7=101215,          //7
			S=2500;             //休止符


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0<=0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0<=0;
        else
            cnt0<=cnt0+1;  
    end
end
assign add_cnt0=1'b1;
assign end_cnt0=add_cnt0 && cnt0==pre_set-1;
assign beep=(cnt0>=(pre_set/2))?1:0;          //每个音符的占空比为50%


//每个音符持续一段时间
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt1<=0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1<=0;
        else
            cnt1<=cnt1+1; 
    end
end
assign add_cnt1=end_cnt0;
assign end_cnt1=add_cnt1 && cnt1==150-1;//小于2^n

//计2^n个音符

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt2<=0;  
    end
    else if(add_cnt2)begin
        if(end_cnt2)
            cnt2<=0;   
        else 
            cnt2<=cnt2+1;
    end
end
assign add_cnt2=end_cnt1;
assign end_cnt2=add_cnt2 && cnt2==1024-1;//改

//存放歌曲的简谱
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pre_set<=0;  
    end
    else begin
        case(cnt2)
            //music code here
        endcase
    end
end
endmodule
