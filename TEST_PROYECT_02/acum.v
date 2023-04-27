module accum(
    input clk, rst, ena,
    input [10:-21] data,

    output reg flag,
    output signed [10:-21] acc
);

reg [1:0] cnt;
reg signed [11:-21] accaux;  

//assign acc = accaux;
//assign acc = {accaux[11], accaux[10:-20]};
assign acc = {accaux[11], accaux[10:-20]};

always@(posedge clk, negedge rst) begin
   if(!rst) begin
        accaux <= 0;
        flag <= 1'b0;
        cnt <= 2'b0;
   end 
   else begin
        if(cnt == 2'b10) begin
            accaux <= 0;
            flag <= 1'b0;
				cnt <= 2'b00;
        end
        else begin
            if(ena == 1'b1) begin
                if(cnt == 2'b01) begin
                    cnt <= cnt + 2'b1;
                    flag <= 1'b1;
                    accaux <= accaux + data;
                end
                else begin
						  accaux <= accaux + data;
						  cnt <= cnt + 2'b1;
                    flag <= 1'b0;
                end
            end
            else begin
                flag <= 1'b0;
            end
        end
   end
end

endmodule
