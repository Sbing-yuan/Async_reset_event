# Asynchronous reset handeling
## Description
Oftentimes, using another clock domain signal to reset digital system is inevitable.   
For example, using a SPI write event to reset timer. SPI in 20MHz, timer in sysclk 1MHz domain.   
Under this scenario, SPI clock pulse is too short to be sync into timer domain.   
Therefore, using asychrounos reset is necessary
## Schematic
Proposed asynchronous reset 
- Async_reset_event : asynchronous reset event, high active
- sys_rstn : sysclk domain global reset, low active
![image](https://github.com/Sbing-yuan/Async_reset_event/blob/main/image.png)
