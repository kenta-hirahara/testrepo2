%
it = it + 1;
kf = csq/nxny;
ef = 0.5/nxny;
bf = 0.5*csq/nxny;
ef2 = 0.5/(b0^2*nxny);
bf2 = 0.5*csq/(b0^2*nxny);
% kinetic energy
    n2 = 0;
    for k=1:ns
        n1  = n2+1;
        n2  = n2 + np(k);
        m = n1:n2;
        ke(it,k) = sum(cv./sqrt(csq-vx(m).^2-vy(m).^2-vz(m).^2)-1.0)*mass(k)*kf;
        vs = sum(vx(m).^2 + vy(m).^2 + vz(m).^2);
        vspara = sum(((vx(m)*bx0+vy(m)*by0+vz(m)*bz0)/b0).^2);
     %Temperature Anisotropy  T_perp/T_para
        At(it,k) = 0.5*(vs/vspara -1);        
    end
    engp(it) = sum(ke(it,:));
% electric field energy
    enge(it) = sum(sum(ex(X2,Y2).^2+ey(X2,Y2).^2+ez(X2,Y2).^2))*ef;
% magnetic field energy
    engb(it) = sum(sum((bx(X2,Y2)-bx0).^2 + (by(X2,Y2)-by0).^2 + (bz(X2,Y2)-bz0).^2))*bf;
% totalenergy
    engt(it) = engp(it) +enge(it)+engb(it);
% parallel and perpendicular energies
    eepara(it) = sum(sum((ex(X2,Y2)*bx0 + ey(X2,Y2)*by0 + ez(X2,Y2)*bz0).^2))*ef2;
    eeperp(it) = enge(it) - eepara(it); 
    ebpara(it) = sum(sum(((bx(X2,Y2)-bx0)*bx0 + (by(X2,Y2)-by0)*by0 + (bz(X2,Y2)-bz0)*bz0).^2))*bf2;
    ebperp(it) = engb(it) - ebpara(it); 
  