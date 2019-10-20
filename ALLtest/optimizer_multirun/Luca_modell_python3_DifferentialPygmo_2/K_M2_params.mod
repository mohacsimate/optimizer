COMMENT

   **************************************************
   File generated by: neuroConstruct v1.5.1 
   **************************************************

   This file holds the implementation in NEURON of the Cell Mechanism:
   K_M (Type: Channel mechanism, Model: ChannelML based process)

   with parameters: 
   /channelml/@units = SI Units 
   /channelml/notes = ChannelML file containing a single Channel description 
   /channelml/channel_type/@name = K_M 
   /channelml/channel_type/status/@value = stable 
   /channelml/channel_type/status/comment = Equations adapted from Kali, model from Borg-Graham (1998) 
   /channelml/channel_type/status/contributor/name = Szoke Boglarka 
   /channelml/channel_type/notes = Muscarine-sensitive K channel in CA1 pyramid cell 
   /channelml/channel_type/authorList/modelTranslator/name = Szoke Boglarka 
   /channelml/channel_type/authorList/modelTranslator/institution = PPKE-ITK 
   /channelml/channel_type/authorList/modelTranslator/email = szoboce - at - digitus.itk.ppke.hu 
   /channelml/channel_type/current_voltage_relation/@cond_law = ohmic 
   /channelml/channel_type/current_voltage_relation/@ion = k 
   /channelml/channel_type/current_voltage_relation/@default_gmax = 30 
   /channelml/channel_type/current_voltage_relation/@default_erev = -0.080 
   /channelml/channel_type/current_voltage_relation/gate/@name = X 
   /channelml/channel_type/current_voltage_relation/gate/@instances = 2 
   /channelml/channel_type/current_voltage_relation/gate/closed_state/@id = X0 
   /channelml/channel_type/current_voltage_relation/gate/open_state/@id = X 
   /channelml/channel_type/current_voltage_relation/gate/time_course/@name = tau 
   /channelml/channel_type/current_voltage_relation/gate/time_course/@from = X0 
   /channelml/channel_type/current_voltage_relation/gate/time_course/@to = X 
   /channelml/channel_type/current_voltage_relation/gate/time_course/@expr_form = generic 
   /channelml/channel_type/current_voltage_relation/gate/time_course/@expr = (1 / ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) + (5.0 * (exp ((0.8 - 1)  * (v - (-0.018)) / 0.003)))) + 0.02) 
   /channelml/channel_type/current_voltage_relation/gate/steady_state/@name = inf 
   /channelml/channel_type/current_voltage_relation/gate/steady_state/@from = X0 
   /channelml/channel_type/current_voltage_relation/gate/steady_state/@to = X 
   /channelml/channel_type/current_voltage_relation/gate/steady_state/@expr_form = generic 
   /channelml/channel_type/current_voltage_relation/gate/steady_state/@expr = ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) / ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) + (5.0 * (exp ((0.8 - 1)  * (v - (-0.018)) / 0.003))))) 
   /channelml/channel_type/impl_prefs/table_settings/@max_v = 0.05 
   /channelml/channel_type/impl_prefs/table_settings/@min_v = -0.1 
   /channelml/channel_type/impl_prefs/table_settings/@table_divisions = 3000 

// File from which this was generated: /home/kali/nC_projects/CA1_NEURON/cellMechanisms/K_M/K_M.xml

// XSL file with mapping to simulator: /home/kali/nC_projects/CA1_NEURON/cellMechanisms/K_M/ChannelML_v1.8.1_NEURONmod.xsl

ENDCOMMENT


?  This is a NEURON mod file generated from a ChannelML file

?  Unit system of original ChannelML file: SI Units

COMMENT
    ChannelML file containing a single Channel description
ENDCOMMENT

TITLE Channel: K_M

COMMENT
    Muscarine-sensitive K channel in CA1 pyramid cell
ENDCOMMENT


UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (S) = (siemens)
    (um) = (micrometer)
    (molar) = (1/liter)
    (mM) = (millimolar)
    (l) = (liter)
}


    
NEURON {
      

    SUFFIX K_M2_params
    USEION k READ ek WRITE ik VALENCE 1  ? reversal potential of ion is read, outgoing current is written
           
        
    RANGE gmax, gion, ik
    
    RANGE Xinf, Xtau
	
	RANGE X_v0, X_k0, X_kt, X_gamma, X_tau0
    
}

PARAMETER { 
      

    gmax = 0.0030 (S/cm2)  ? default value, should be overwritten when conductance placed on cell
	
	X_v0 = -0.05 : Note units of this will be determined by its usage in the generic functions (mV)

    X_k0 = 0.004 : Note units of this will be determined by its usage in the generic functions (mV)

    X_kt = 5 : Note units of this will be determined by its usage in the generic functions (1/ms)

    X_gamma = 0.8 : Note units of this will be determined by its usage in the generic functions

    X_tau0 = 0.002 : Note units of this will be determined by its usage in the generic functions (ms)
    
}



ASSIGNED {
      

    v (mV)
    
    celsius (degC)
          

    ? Reversal potential of k
    ek (mV)
    ? The outward flow of ion: k calculated by rate equations...
    ik (mA/cm2)
    
    
    gion (S/cm2)
    Xinf
    Xtau (ms)
    
}

BREAKPOINT { 
                        
    SOLVE states METHOD cnexp
         

    gion = gmax*((X)^2)      

    ik = gion*(v - ek)
            

}



INITIAL {
    
    ek = -80
        
    rates(v)
    X = Xinf
        
    
}
    
STATE {
    X
    
}

DERIVATIVE states {
    rates(v)
    X' = (Xinf - X)/Xtau
    
}

PROCEDURE rates(v(mV)) {  
    
    ? Note: not all of these may be used, depending on the form of rate equations
    LOCAL  alpha, beta, tau, inf, gamma, zeta, temp_adj_X, A_tau_X, B_tau_X, Vhalf_tau_X, A_inf_X, B_inf_X, Vhalf_inf_X
        
    TABLE Xinf, Xtau
 DEPEND celsius, X_v0, X_k0, X_kt, X_gamma, X_tau0
 FROM -100 TO 50 WITH 3000
    
    
    UNITSOFF
    temp_adj_X = 1
    
            
                
           

        
    ?      ***  Adding rate equations for gate: X  ***
         
    ? Found a generic form of the rate equation for tau, using expression: (1 / ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) + (5.0 * (exp ((0.8 - 1)  * (v - (-0.018)) / 0.003)))) + 0.02)
    
    ? Note: Equation (and all ChannelML file values) in SI Units so need to convert v first...
    
    v = v * 0.0010   ? temporarily set v to units of equation...
            
    :tau = (1 / ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) + (5.0 * (exp ((0.8 - 1)  * (v - (-0.018)) / 0.003)))) + 0.002)
     
	tau = 1 / ( (X_kt * (exp (X_gamma * (v - X_v0) / X_k0))) + (X_kt * (exp ((X_gamma - 1)  * (v - X_v0) / X_k0)))) + X_tau0


	 
    ? Set correct units of tau for NEURON
    tau = tau * 1000 
    
    v = v * 1000   ? reset v
        
    Xtau = tau/temp_adj_X
     
    ? Found a generic form of the rate equation for inf, using expression: ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) / ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) + (5.0 * (exp ((0.8 - 1)  * (v - (-0.018)) / 0.003)))))
    
    ? Note: Equation (and all ChannelML file values) in SI Units so need to convert v first...
    
    v = v * 0.0010   ? temporarily set v to units of equation...
            
    :inf = ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) / ((5.0 * (exp (0.8 * (v - (-0.018)) / 0.003))) + (5.0 * (exp ((0.8 - 1)  * (v - (-0.018)) / 0.003)))))
         
	inf = ((X_kt * (exp (X_gamma * (v - X_v0) / X_k0))) / ((X_kt * (exp (X_gamma * (v - X_v0) / X_k0))) + (X_kt * (exp ((X_gamma - 1)  * (v - X_v0) / X_k0)))))

    
    v = v * 1000   ? reset v
        
    Xinf = inf
          
       
    
    ?     *** Finished rate equations for gate: X ***
    

         

}


UNITSON

