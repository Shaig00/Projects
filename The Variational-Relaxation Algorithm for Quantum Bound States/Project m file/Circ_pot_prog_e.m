classdef Circ_pot_prog_e < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        GridLayout                    matlab.ui.container.GridLayout
        LeftPanel                     matlab.ui.container.Panel
        UIAxes                        matlab.ui.control.UIAxes
        RadiusSliderLabel             matlab.ui.control.Label
        RadiusSlider                  matlab.ui.control.Slider
        PotentialStrengthSliderLabel  matlab.ui.control.Label
        PotentialStrengthSlider       matlab.ui.control.Slider
        CircularPotentialLabel        matlab.ui.control.Label
        InvertCheckBox                matlab.ui.control.CheckBox
        PotentialStrengthEditFieldLabel  matlab.ui.control.Label
        PotentialStrengthEditField    matlab.ui.control.NumericEditField
        InfoWhitecolourindicatesthefieldwithzeropotentialLabel  matlab.ui.control.Label
        RightPanel                    matlab.ui.container.Panel
        UIAxes_2                      matlab.ui.control.UIAxes
        UIAxes_3                      matlab.ui.control.UIAxes
        UIAxes_4                      matlab.ui.control.UIAxes
        UIAxes_5                      matlab.ui.control.UIAxes
        DWavefunctionStatesLabel      matlab.ui.control.Label
        GroundstateEnergyEditFieldLabel  matlab.ui.control.Label
        GroundstateEnergyEditField    matlab.ui.control.NumericEditField
        FirstexcitedstateEnergyEditFieldLabel  matlab.ui.control.Label
        FirstexcitedstateEnergyEditField  matlab.ui.control.NumericEditField
        SecondexcitedstateEnergyEditFieldLabel  matlab.ui.control.Label
        SecondexcitedstateEnergyEditField  matlab.ui.control.NumericEditField
        ThirdexcitedstateEnergyEditFieldLabel  matlab.ui.control.Label
        ThirdexcitedstateEnergyEditField  matlab.ui.control.NumericEditField
        StartButton                   matlab.ui.control.Button
        Label                         matlab.ui.control.Label
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    
    properties (Access = private)
        N=100;
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: RadiusSlider
        function RadiusSliderValueChanged(app, event)
            r = app.RadiusSlider.Value;
            
            if app.InvertCheckBox.Value==1
                Vc=circlepotential(r,app.N+1,app.PotentialStrengthSlider.Value);
            else
                Vc=circlepotential(r,app.N+1,-app.PotentialStrengthSlider.Value);
            end
            
            
            if app.InvertCheckBox.Value==1
                V=circlepotim(app.RadiusSlider.Value,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [1 1 1; 0 0 0]);
            else
                V=circlepotim(app.RadiusSlider.Value,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [0 0 0; 1 1 1]);
            end  
            
            
            %reaction to change by computing everything again
            if app.InvertCheckBox.Value==1
                [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefuncINV(Vc,app.N);
                app.GroundstateEnergyEditField.Value=exEn;
                app.FirstexcitedstateEnergyEditField.Value=exE1;
                app.SecondexcitedstateEnergyEditField.Value=exE2;
                app.ThirdexcitedstateEnergyEditField.Value=exE3;
                contourf(app.UIAxes_3,F_psin);
                contourf(app.UIAxes_4,F_psi1);
                contourf(app.UIAxes_2,F_psi2);
                contourf(app.UIAxes_5,F_psi3);
            else
                [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefunc(Vc,app.N);
                app.GroundstateEnergyEditField.Value=exEn;
                app.FirstexcitedstateEnergyEditField.Value=exE1;
                app.SecondexcitedstateEnergyEditField.Value=exE2;
                app.ThirdexcitedstateEnergyEditField.Value=exE3;
                contourf(app.UIAxes_3,F_psin);
                contourf(app.UIAxes_4,F_psi1);
                contourf(app.UIAxes_2,F_psi2);
                contourf(app.UIAxes_5,F_psi3);
            end
        end

        % Value changing function: RadiusSlider
        function RadiusSliderValueChanging(app, event)
            changingRadius = event.Value;
            
            
            if app.InvertCheckBox.Value==1
                V=circlepotim(changingRadius,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [1 1 1; 0 0 0]);
            else
                V=circlepotim(changingRadius,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [0 0 0; 1 1 1]);
            end 
        end

        % Value changed function: PotentialStrengthSlider
        function PotentialStrengthSliderValueChanged(app, event)
            V_max = app.PotentialStrengthSlider.Value;
            
            app.PotentialStrengthEditField.Value=V_max;
            
            if app.InvertCheckBox.Value==1
                Vc=circlepotential(app.RadiusSlider.Value,app.N+1,V_max);
            else
                Vc=circlepotential(app.RadiusSlider.Value,app.N+1,-V_max);
            end
            
            if app.InvertCheckBox.Value==1
                V=circlepotim(app.RadiusSlider.Value,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [1 1 1; 0 0 0]);
            else
                V=circlepotim(app.RadiusSlider.Value,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [0 0 0; 1 1 1]);
            end  
            
            
            %reaction to Potential change
            if app.InvertCheckBox.Value==1
                [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefuncINV(Vc,app.N);
                app.GroundstateEnergyEditField.Value=exEn;
                app.FirstexcitedstateEnergyEditField.Value=exE1;
                app.SecondexcitedstateEnergyEditField.Value=exE2;
                app.ThirdexcitedstateEnergyEditField.Value=exE3;
                contourf(app.UIAxes_3,F_psin);
                contourf(app.UIAxes_4,F_psi1);
                contourf(app.UIAxes_2,F_psi2);
                contourf(app.UIAxes_5,F_psi3);
            else
                [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefunc(Vc,app.N);
                app.GroundstateEnergyEditField.Value=exEn;
                app.FirstexcitedstateEnergyEditField.Value=exE1;
                app.SecondexcitedstateEnergyEditField.Value=exE2;
                app.ThirdexcitedstateEnergyEditField.Value=exE3;
                contourf(app.UIAxes_3,F_psin);
                contourf(app.UIAxes_4,F_psi1);
                contourf(app.UIAxes_2,F_psi2);
                contourf(app.UIAxes_5,F_psi3);
            end
        end

        % Value changed function: InvertCheckBox
        function InvertCheckBoxValueChanged(app, event)
            Value = app.InvertCheckBox.Value;
            
            
            if Value==1
                Vc=circlepotential(app.RadiusSlider.Value,app.N+1,app.PotentialStrengthSlider.Value);
            else
                Vc=circlepotential(app.RadiusSlider.Value,app.N+1,-app.PotentialStrengthSlider.Value);
            end
            
            if Value==1
                V=circlepotim(app.RadiusSlider.Value,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [1 1 1; 0 0 0]);
            else
                V=circlepotim(app.RadiusSlider.Value,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [0 0 0; 1 1 1]);
            end  
            
            
            if app.InvertCheckBox.Value==1
                [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefuncINV(Vc,app.N);
                app.GroundstateEnergyEditField.Value=exEn;
                app.FirstexcitedstateEnergyEditField.Value=exE1;
                app.SecondexcitedstateEnergyEditField.Value=exE2;
                app.ThirdexcitedstateEnergyEditField.Value=exE3;
                contourf(app.UIAxes_3,F_psin);
                contourf(app.UIAxes_4,F_psi1);
                contourf(app.UIAxes_2,F_psi2);
                contourf(app.UIAxes_5,F_psi3);
            else
                [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefunc(Vc,app.N);
                app.GroundstateEnergyEditField.Value=exEn;
                app.FirstexcitedstateEnergyEditField.Value=exE1;
                app.SecondexcitedstateEnergyEditField.Value=exE2;
                app.ThirdexcitedstateEnergyEditField.Value=exE3;
                contourf(app.UIAxes_3,F_psin);
                contourf(app.UIAxes_4,F_psi1);
                contourf(app.UIAxes_2,F_psi2);
                contourf(app.UIAxes_5,F_psi3);
            end
        end

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
            
            app.PotentialStrengthEditField.Value=app.PotentialStrengthSlider.Value;
                 
            if app.InvertCheckBox.Value==1
                Vc=circlepotential(app.RadiusSlider.Value,app.N+1,app.PotentialStrengthSlider.Value);
            else
                Vc=circlepotential(app.RadiusSlider.Value,app.N+1,-app.PotentialStrengthSlider.Value);
            end
            
            if app.InvertCheckBox.Value==1
                V=circlepotim(app.RadiusSlider.Value,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [1 1 1; 0 0 0]);
            else
                V=circlepotim(app.RadiusSlider.Value,app.N+1);
                imshow(V,'Parent',app.UIAxes);
                colormap(app.UIAxes, [0 0 0; 1 1 1]);
            end 
            
            
            if app.InvertCheckBox.Value==1
                [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefuncINV(Vc,app.N);
                app.GroundstateEnergyEditField.Value=exEn;
                app.FirstexcitedstateEnergyEditField.Value=exE1;
                app.SecondexcitedstateEnergyEditField.Value=exE2;
                app.ThirdexcitedstateEnergyEditField.Value=exE3;
                contourf(app.UIAxes_3,F_psin);
                contourf(app.UIAxes_4,F_psi1);
                contourf(app.UIAxes_2,F_psi2);
                contourf(app.UIAxes_5,F_psi3);
            else
                [exEn,exE1,exE2,exE3,F_psin,F_psi1,F_psi2,F_psi3]=wavefunc(Vc,app.N);
                app.GroundstateEnergyEditField.Value=exEn;
                app.FirstexcitedstateEnergyEditField.Value=exE1;
                app.SecondexcitedstateEnergyEditField.Value=exE2;
                app.ThirdexcitedstateEnergyEditField.Value=exE3;
                contourf(app.UIAxes_3,F_psin);
                contourf(app.UIAxes_4,F_psi1);
                contourf(app.UIAxes_2,F_psi2);
                contourf(app.UIAxes_5,F_psi3);
            end
        end

        % Value changing function: PotentialStrengthSlider
        function PotentialStrengthSliderValueChanging(app, event)
            changingValue = event.Value;
             app.PotentialStrengthEditField.Value=changingValue;
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {731, 731};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {435, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 1229 731];
            app.UIFigure.Name = 'UI Figure';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {435, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create UIAxes
            app.UIAxes = uiaxes(app.LeftPanel);
            title(app.UIAxes, 'Circular Potential Well')
            xlabel(app.UIAxes, '')
            ylabel(app.UIAxes, '')
            app.UIAxes.XTick = [];
            app.UIAxes.YTick = [];
            app.UIAxes.Position = [91 393 253 234];

            % Create RadiusSliderLabel
            app.RadiusSliderLabel = uilabel(app.LeftPanel);
            app.RadiusSliderLabel.HorizontalAlignment = 'right';
            app.RadiusSliderLabel.FontWeight = 'bold';
            app.RadiusSliderLabel.Position = [40 41 45 22];
            app.RadiusSliderLabel.Text = 'Radius';

            % Create RadiusSlider
            app.RadiusSlider = uislider(app.LeftPanel);
            app.RadiusSlider.Limits = [0 40];
            app.RadiusSlider.MajorTicks = [0 5 10 15 20 25 30 35 40];
            app.RadiusSlider.Orientation = 'vertical';
            app.RadiusSlider.ValueChangedFcn = createCallbackFcn(app, @RadiusSliderValueChanged, true);
            app.RadiusSlider.ValueChangingFcn = createCallbackFcn(app, @RadiusSliderValueChanging, true);
            app.RadiusSlider.MinorTicks = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40];
            app.RadiusSlider.FontWeight = 'bold';
            app.RadiusSlider.Position = [103 50 3 257];
            app.RadiusSlider.Value = 10;

            % Create PotentialStrengthSliderLabel
            app.PotentialStrengthSliderLabel = uilabel(app.LeftPanel);
            app.PotentialStrengthSliderLabel.HorizontalAlignment = 'right';
            app.PotentialStrengthSliderLabel.FontWeight = 'bold';
            app.PotentialStrengthSliderLabel.Position = [213 41 109 22];
            app.PotentialStrengthSliderLabel.Text = 'Potential Strength';

            % Create PotentialStrengthSlider
            app.PotentialStrengthSlider = uislider(app.LeftPanel);
            app.PotentialStrengthSlider.Limits = [0 200];
            app.PotentialStrengthSlider.MajorTicks = [0 20 40 60 80 100 120 140 160 180 200];
            app.PotentialStrengthSlider.Orientation = 'vertical';
            app.PotentialStrengthSlider.ValueChangedFcn = createCallbackFcn(app, @PotentialStrengthSliderValueChanged, true);
            app.PotentialStrengthSlider.ValueChangingFcn = createCallbackFcn(app, @PotentialStrengthSliderValueChanging, true);
            app.PotentialStrengthSlider.FontWeight = 'bold';
            app.PotentialStrengthSlider.Position = [343 50 3 257];
            app.PotentialStrengthSlider.Value = 100;

            % Create CircularPotentialLabel
            app.CircularPotentialLabel = uilabel(app.LeftPanel);
            app.CircularPotentialLabel.FontSize = 36;
            app.CircularPotentialLabel.FontWeight = 'bold';
            app.CircularPotentialLabel.FontColor = [0.6392 0.1412 0.1412];
            app.CircularPotentialLabel.Position = [79 653 307 46];
            app.CircularPotentialLabel.Text = 'Circular Potential';

            % Create InvertCheckBox
            app.InvertCheckBox = uicheckbox(app.LeftPanel);
            app.InvertCheckBox.ValueChangedFcn = createCallbackFcn(app, @InvertCheckBoxValueChanged, true);
            app.InvertCheckBox.Text = 'Invert';
            app.InvertCheckBox.Position = [53 335 86 26];

            % Create PotentialStrengthEditFieldLabel
            app.PotentialStrengthEditFieldLabel = uilabel(app.LeftPanel);
            app.PotentialStrengthEditFieldLabel.HorizontalAlignment = 'right';
            app.PotentialStrengthEditFieldLabel.Position = [171 337 100 22];
            app.PotentialStrengthEditFieldLabel.Text = 'Potential Strength';

            % Create PotentialStrengthEditField
            app.PotentialStrengthEditField = uieditfield(app.LeftPanel, 'numeric');
            app.PotentialStrengthEditField.Position = [286 337 100 22];

            % Create InfoWhitecolourindicatesthefieldwithzeropotentialLabel
            app.InfoWhitecolourindicatesthefieldwithzeropotentialLabel = uilabel(app.LeftPanel);
            app.InfoWhitecolourindicatesthefieldwithzeropotentialLabel.HorizontalAlignment = 'center';
            app.InfoWhitecolourindicatesthefieldwithzeropotentialLabel.VerticalAlignment = 'bottom';
            app.InfoWhitecolourindicatesthefieldwithzeropotentialLabel.FontSize = 11;
            app.InfoWhitecolourindicatesthefieldwithzeropotentialLabel.FontAngle = 'italic';
            app.InfoWhitecolourindicatesthefieldwithzeropotentialLabel.Position = [82 379 277 22];
            app.InfoWhitecolourindicatesthefieldwithzeropotentialLabel.Text = 'Info: White colour indicates the field with zero potential.';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.RightPanel);
            title(app.UIAxes_2, '\psi_{1,2}')
            xlabel(app.UIAxes_2, 'X')
            ylabel(app.UIAxes_2, 'Y')
            app.UIAxes_2.FontSize = 11;
            app.UIAxes_2.XTick = [];
            app.UIAxes_2.YTick = [];
            app.UIAxes_2.Position = [98 104 253 234];

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.RightPanel);
            title(app.UIAxes_3, '\psi_{1,1}')
            xlabel(app.UIAxes_3, 'X')
            ylabel(app.UIAxes_3, 'Y')
            app.UIAxes_3.FontSize = 11;
            app.UIAxes_3.XTick = [];
            app.UIAxes_3.YTick = [];
            app.UIAxes_3.Position = [99 385 253 234];

            % Create UIAxes_4
            app.UIAxes_4 = uiaxes(app.RightPanel);
            title(app.UIAxes_4, '\psi_{2,1}')
            xlabel(app.UIAxes_4, 'X')
            ylabel(app.UIAxes_4, 'Y')
            app.UIAxes_4.FontSize = 11;
            app.UIAxes_4.XTick = [];
            app.UIAxes_4.YTick = [];
            app.UIAxes_4.Position = [448 385 253 234];

            % Create UIAxes_5
            app.UIAxes_5 = uiaxes(app.RightPanel);
            title(app.UIAxes_5, '\psi_{2,2}')
            xlabel(app.UIAxes_5, 'X')
            ylabel(app.UIAxes_5, 'Y')
            app.UIAxes_5.XTick = [];
            app.UIAxes_5.YTick = [];
            app.UIAxes_5.Position = [447 104 253 234];

            % Create DWavefunctionStatesLabel
            app.DWavefunctionStatesLabel = uilabel(app.RightPanel);
            app.DWavefunctionStatesLabel.FontSize = 36;
            app.DWavefunctionStatesLabel.FontWeight = 'bold';
            app.DWavefunctionStatesLabel.FontColor = [0.3059 0.4392 0.1333];
            app.DWavefunctionStatesLabel.Position = [321 653 421 46];
            app.DWavefunctionStatesLabel.Text = '2D Wavefunction States';

            % Create GroundstateEnergyEditFieldLabel
            app.GroundstateEnergyEditFieldLabel = uilabel(app.RightPanel);
            app.GroundstateEnergyEditFieldLabel.HorizontalAlignment = 'right';
            app.GroundstateEnergyEditFieldLabel.Position = [121 358 117 22];
            app.GroundstateEnergyEditFieldLabel.Text = 'Ground state Energy';

            % Create GroundstateEnergyEditField
            app.GroundstateEnergyEditField = uieditfield(app.RightPanel, 'numeric');
            app.GroundstateEnergyEditField.Position = [253 358 100 22];

            % Create FirstexcitedstateEnergyEditFieldLabel
            app.FirstexcitedstateEnergyEditFieldLabel = uilabel(app.RightPanel);
            app.FirstexcitedstateEnergyEditFieldLabel.HorizontalAlignment = 'right';
            app.FirstexcitedstateEnergyEditFieldLabel.Position = [444 358 141 22];
            app.FirstexcitedstateEnergyEditFieldLabel.Text = 'First excited state Energy';

            % Create FirstexcitedstateEnergyEditField
            app.FirstexcitedstateEnergyEditField = uieditfield(app.RightPanel, 'numeric');
            app.FirstexcitedstateEnergyEditField.Position = [600 358 100 22];

            % Create SecondexcitedstateEnergyEditFieldLabel
            app.SecondexcitedstateEnergyEditFieldLabel = uilabel(app.RightPanel);
            app.SecondexcitedstateEnergyEditFieldLabel.HorizontalAlignment = 'right';
            app.SecondexcitedstateEnergyEditFieldLabel.Position = [78 62 158 22];
            app.SecondexcitedstateEnergyEditFieldLabel.Text = 'Second excited state Energy';

            % Create SecondexcitedstateEnergyEditField
            app.SecondexcitedstateEnergyEditField = uieditfield(app.RightPanel, 'numeric');
            app.SecondexcitedstateEnergyEditField.Position = [251 62 100 22];

            % Create ThirdexcitedstateEnergyEditFieldLabel
            app.ThirdexcitedstateEnergyEditFieldLabel = uilabel(app.RightPanel);
            app.ThirdexcitedstateEnergyEditFieldLabel.HorizontalAlignment = 'right';
            app.ThirdexcitedstateEnergyEditFieldLabel.Position = [441 62 145 22];
            app.ThirdexcitedstateEnergyEditFieldLabel.Text = 'Third excited state Energy';

            % Create ThirdexcitedstateEnergyEditField
            app.ThirdexcitedstateEnergyEditField = uieditfield(app.RightPanel, 'numeric');
            app.ThirdexcitedstateEnergyEditField.Position = [601 62 100 22];

            % Create StartButton
            app.StartButton = uibutton(app.RightPanel, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.BackgroundColor = [0.502 0.502 0.502];
            app.StartButton.FontName = 'Leelawadee UI';
            app.StartButton.FontSize = 30;
            app.StartButton.FontWeight = 'bold';
            app.StartButton.FontColor = [0.9412 0.9412 0.9412];
            app.StartButton.Position = [98 642 182 69];
            app.StartButton.Text = '[Start]';

            % Create Label
            app.Label = uilabel(app.RightPanel);
            app.Label.FontWeight = 'bold';
            app.Label.Position = [155 9 559 22];
            app.Label.Text = 'Info: Yellow colour indicates positive values of Z and blue colour of negative values of Z. ';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Circ_pot_prog_e

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end