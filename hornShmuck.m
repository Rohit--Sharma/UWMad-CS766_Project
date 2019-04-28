function abc = hornShmuck(imgs)
    opticFlow = opticalFlowLK;
    
    for i = 1 : size(imgs, 1)
        frameRGB = imgs{i};
        frameGray = rgb2gray(frameRGB);  
        flow = estimateFlow(opticFlow,frameGray);
        figure, imshow(frameRGB);
        hold on;
        plot(flow,'DecimationFactor',[5 5],'ScaleFactor',60);
        hold off;
        pause(10^-3);
        abc=1;
    end
end
