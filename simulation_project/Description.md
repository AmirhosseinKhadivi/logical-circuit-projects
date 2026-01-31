<h1>🎟️ Automatic Ticketing System (VHDL – FPGA)</h1>

<h2>Course</h2>
<p><b>Digital Logic Laboratory</b></p>

<h2>University</h2>
<p><b>University of Guilan</b></p>

<h2>Written by:</h2>
<ul>
  <li><b>Amirhossein Khadivi</b></li>
</ul>

<h2>Description</h2>
<p>
This project implements an <b>automatic ticketing (queue management) system</b> using <b>VHDL</b>.
The system is designed for FPGA-based implementation and models a real-world ticket issuing process.
The design can be implemented using an <b>FSM (Finite State Machine)</b>.
</p>

<h2>Inputs</h2>
<ul>
  <li><b>req1, req2, req3</b>: Request inputs for different service sections</li>
  <li><b>clk</b>: Clock signal</li>
  <li><b>rst</b>: Reset signal</li>
</ul>

<h2>Outputs</h2>
<ul>
  <li><b>ticket_num</b>: 4-bit <code>std_logic_vector</code> representing the ticket number</li>
  <li><b>current_section</b>: Indicates the selected service section</li>
  <li><b>new_ticket</b>: Asserted when a new ticket is issued</li>
</ul>

<h2>Functionality</h2>
<ul>
  <li>Issues a new ticket when a request button is pressed</li>
  <li>Increments the ticket number for each issued ticket</li>
  <li>Displays the ticket number and selected section</li>
  <li>Resets the ticket number to zero when <b>rst</b> is activated</li>
</ul>

<h2>Tools</h2>
<ul>
  <li><b>Language:</b> VHDL</li>
  <li><b>FPGA Tool:</b> Xilinx ISE</li>
</ul>

<h2>Notes</h2>
<p>
Testbench files and waveform screenshots are included as part of the project.
</p>
