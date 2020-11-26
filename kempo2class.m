classdef kempo2class
    properties
        inputParameters
        initializedParticles %struct of array
    end
    methods 
        function initializedParticles = kempo2class(inputParameters)
        renormalization;
        initial;
        position; 
        charge;
        potential;
        energy;
        end
    
        function job
        for itime = 1:ntime
            jtime = jtime +1;
            bfield;
            rvelocity;
            position;
            current;
            position;
            bfield;
            efield;
            charge;
            potential;
            diagnostics;
       end
    end
end