module traffic_light_controller (
    input clk,
    input rst,
    output reg [2:0] lightM1,
    output reg [2:0] lightM2,
    output reg [2:0] lightM3,
    output reg [2:0] lightM4
);

    // Define light colors for clarity
    parameter RED    = 3'b100;
    parameter YELLOW = 3'b010;
    parameter GREEN  = 3'b001;

    // Define the states for the FSM
    parameter S1 = 3'b000; // M1/M3 Green, M2/M4 Red
    parameter S2 = 3'b001; // M1/M3 Yellow, M2/M4 Red
    parameter S3 = 3'b010; // M2/M4 Green, M1/M3 Red
    parameter S4 = 3'b011; // M2/M4 Yellow, M1/M3 Red

    // State and counter registers
    reg [2:0] current_state, next_state;
    reg [3:0] count;

    // Timing parameters for green and yellow lights
    parameter T_GREEN = 10;
    parameter T_YELLOW = 3;

    // State Transition Logic (Sequential)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S1;
            count <= 0;
        end else begin
            current_state <= next_state;
            // Increment or reset the counter
            if (next_state != current_state) begin
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end

    // Next State Logic (Combinational)
    always @(*) begin
        case (current_state)
            S1: next_state = (count < T_GREEN) ? S1 : S2;
            S2: next_state = (count < T_YELLOW) ? S2 : S3;
            S3: next_state = (count < T_GREEN) ? S3 : S4;
            S4: next_state = (count < T_YELLOW) ? S4 : S1;
            default: next_state = S1;
        endcase
    end

    // Output Logic (Combinational)
    always @(current_state) begin
        case (current_state)
            S1: begin // M1/M3 Green
                lightM1 <= GREEN;
                lightM2 <= RED;
                lightM3 <= GREEN;
                lightM4 <= RED;
            end
            S2: begin // M1/M3 Yellow
                lightM1 <= YELLOW;
                lightM2 <= RED;
                lightM3 <= YELLOW;
                lightM4 <= RED;
            end
            S3: begin // M2/M4 Green
                lightM1 <= RED;
                lightM2 <= GREEN;
                lightM3 <= RED;
                lightM4 <= GREEN;
            end
            S4: begin // M2/M4 Yellow
                lightM1 <= RED;
                lightM2 <= YELLOW;
                lightM3 <= RED;
                lightM4 <= YELLOW;
            end
            default: begin
                lightM1 <= RED;
                lightM2 <= RED;
                lightM3 <= RED;
                lightM4 <= RED;
            end
        endcase
    end

endmodule
