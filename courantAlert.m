%Courant Condition Alert
if app.dxEditField.Value / app.dtEditField.Value <= sqrt(2) * app.cvEditField.Value                
    uialert(app.KEMPO2UIFigure, app.courantCondMsg, 'Warning');
    return
end 