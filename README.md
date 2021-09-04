# Handshake_protocol_of_AXI4  
  
This is a little project and understangding of the handshake_protocol of AXI4 and the  realization in a register way.  

## Handshake_protocol
As we all know that the AXI4 bus have 5 channels and all of them follow the hand_protocol.And this protocal transmit messages by the signs of VALID & READY.  
1.The source asserts VALID to indicate that its data or address is able to transimit.  
2.The destination asserts READY to indicate that destination is ready to recive the data/address of source.  
Only if both of them are up level and the data/address can be transmitted.And de-assert the two signs after all transmissions.  
This protocol has a superiority that both the source and destination can control the speed of messages transimit.    
And there are three cases according to this protocol:  
  
### 1.VALID before READY  
>If VALID arrives before READY.This signal and the valid data can't de-assert till the READY arrives and receive the data.  
>This can sure that the destination won't miss this valid data.  
>[pic]  
>If the destination is not ready yet but the source starts to generate new valid datas,the need more registers to store them.  
  
### 2.READY before VALID  
>If READY arrives before VALID.The destination will wait VALID to receive the data.   
>Once VALID appers ,the destination starts to get data.When destination is't able to get new datas,READY de-assert.    
>[pic]  
>The READY can de-assert and assert casually before VALID arrives.And this won't influence the data transmission.  
  
### 3.VALID with READY  
>If READY and VALID arrive simultaneously just transmit data.   
>And the transmission can keep many clks if the two signals keep high-level.    
>[pic]  
  
## Register scheme  
Sometimes we need to register signal to timing repair.And for different signal there will be different schemes.And it requires that the protocol will be still followed and can't transimit wrong datas.
  
### 1.Register VALID  
>Register the VALID and data from source whatever.   
>simultaneously it can fullfill the back-press to control the transmission speed.     
>[pic]  
>The VALID and data will delay one clock to output.And use ready_down and valid_down to be the enable signal of this register.Only if slave receives the data or this register doesn't  get valid data yet this register can get new datas.If current valid data is not received by slave,the register will always keep current data.  
  
### 2.Register READY 
>Register the READY from destination.   
>If we just use the registered READY directly there may be some errors.Because we need READY to tell the upstream if slave can get new datas.If we use the dalayed READY we may miss a data.  
>Thus adding a temp signal to accept.The temp only works when the READY changes suddenly.If the data after the sudden change is valid,assert the temp and store this data.If temp asserts and READY is coming, de-assert temp and transmit the temp data to slave.        
>[pic]  
>In normal times (not a sudden change of READY),just bypass the temp register.And the output of valid_down is a XOR of temp and VALID ,and if temp is high-level ,output the temp data, or output the direct connection data. 
  



