% classdef IntegrationApp < matlab.apps.AppBase
% 
%     % Properties that correspond to app components
%     properties (Access = public)
%         UIFigure              matlab.ui.Figure
%         FunctionLabel         matlab.ui.control.Label
%         FunctionEditField     matlab.ui.control.EditField
%         RangeLabel            matlab.ui.control.Label
%         LowerBoundEditField   matlab.ui.control.NumericEditField
%         UpperBoundEditField   matlab.ui.control.NumericEditField
%         SubintervalsLabel     matlab.ui.control.Label
%         SubintervalsEditField matlab.ui.control.NumericEditField
%         CalculateButton       matlab.ui.control.Button
%         ResultLabel           matlab.ui.control.Label
%         GraphAxes             matlab.ui.control.UIAxes
%     end
% 
%     % Callbacks that handle component events
%     methods (Access = private)
% 
%         % Button pushed function: CalculateButton
%         function CalculateButtonPushed(app, ~)
%             try
%                 % L?y giá tr? t? các tr??ng nh?p li?u
%                 f = str2func(['@(x) ' app.FunctionEditField.Value]);
%                 a = app.LowerBoundEditField.Value;
%                 b = app.UpperBoundEditField.Value;
%                 N = app.SubintervalsEditField.Value;
% 
%                 % Tính toán giá tr? tích phân
%                 trapezoidal_result = app.trapezoidalRule(f, a, b, N);
%                 simpsons_result = app.simpsonsRule(f, a, b, N);
%                 exact_result = app.exactIntegral(f, a, b);
% 
%                 % Hi?n th? k?t qu?
%                 result_str = sprintf('Trapezoidal: %.10f\nSimpson''s: %.10f\nExact: %.10f', trapezoidal_result, simpsons_result, exact_result);
%                 app.ResultLabel.Text = result_str;
% 
%                 % V? ?? th?
%                 x_values = linspace(a, b, 100);
%                 y_values = arrayfun(f, x_values);
% 
%                 plot(app.GraphAxes, x_values, y_values);
%                 xlabel(app.GraphAxes, 'x');
%                 ylabel(app.GraphAxes, 'f(x)');
%                 title(app.GraphAxes, 'Graph of f(x)');
% 
%             catch
%                 % X? lý l?i khi nh?p li?u không h?p l?
%                 app.ResultLabel.Text = 'Invalid input. Please enter numeric values.';
%             end
%         end
%     end
% 
%     % Methods that are called when a component is created or modified
%     methods (Access = private)
% 
%         % Create UIFigure and components
%         function createComponents(app)
%             app.UIFigure = uifigure('Position', [100, 100, 640, 480], 'Name', 'Integration App', 'Resize', 'off');
% 
%             app.FunctionLabel = uilabel(app.UIFigure, 'Text', 'Enter f(x):', 'Position', [28, 437, 61, 22]);
%             app.FunctionEditField = uieditfield(app.UIFigure, 'Position', [109, 437, 157, 22]);
% 
%             app.RangeLabel = uilabel(app.UIFigure, 'Text', 'Enter integration range [a;b]:', 'Position', [28, 395, 155, 22]);
%             app.LowerBoundEditField = uieditfield(app.UIFigure, 'numeric', 'Position', [198, 395, 68, 22], 'Value', 0);
%             app.UpperBoundEditField = uieditfield(app.UIFigure, 'numeric', 'Position', [278, 395, 68, 22], 'Value', 1);
% 
%             app.SubintervalsLabel = uilabel(app.UIFigure, 'Text', 'Enter the number of subintervals (N):', 'Position', [28, 358, 222, 22]);
%             app.SubintervalsEditField = uieditfield(app.UIFigure, 'numeric', 'Position', [278, 358, 68, 22], 'Value', 10);
% 
%             app.CalculateButton = uibutton(app.UIFigure, 'push', 'Text', 'Calculate Integration', 'Position', [28, 312, 318, 30], 'ButtonPushedFcn', @(~, ~) CalculateButtonPushed(app));
% 
%             app.ResultLabel = uilabel(app.UIFigure, 'Text', '', 'Position', [28, 243, 318, 63]);
% 
%             app.GraphAxes = uiaxes(app.UIFigure, 'Position', [376, 35, 240, 420]);
%         end
%     end
% 
%     % App creation and deletion
%     methods (Access = public)
% 
%         % Construct app
%         function app = IntegrationApp
%             createComponents(app)
% 
%             % Show the figure after all components are created
%             app.UIFigure.Visible = 'on';
%         end
% 
%         % Code that executes before app deletion
%         function delete(app)
% 
%             % Delete UIFigure when app is deleted
%             delete(app.UIFigure);
%         end
%     end
% 
%     % Methods for app-specific functionality
%     methods (Access = private)
% 
%         function result = trapezoidalRule(~, f, a, b, N)
%             h = (b - a) / N;
%             result = 0.5 * (f(a) + f(b));
%             for i = 1:N-1
%                 result = result + f(a + i * h);
%             end
%             result = result * h;
%         end
% 
%         function result = simpsonsRule(~, f, a, b, N)
%             h = (b - a) / N;
%             result = f(a) + f(b);
%             for i = 1:2:N-1
%                 result = result + 4 * f(a + i * h);
%             end
%             for i = 2:2:N-2
%                 result = result + 2 * f(a + i * h);
%             end
%             result = result * h / 3;
%         end
% 
%         function result = exactIntegral(~, f, a, b)
%             result = integral(f, a, b);
%         end
%     end
% end

syms x;
fx = @(x) x.^3.*sin(x) + x.*cos(x);
a = -1;
b = 1;
N = 10;

% S? d?ng hàm linspace ?? chia ??u các ?i?m
x = linspace(a, b, 1000);

% Tính giá tr? hàm s? t?i các ?i?m x
c = integral(fx,a,b);
disp(c);
y = arrayfun(fx,x);
% V? ?? th?
plot(x,y);
title('?? th? hàm s? f(x)');
xlabel('x');
ylabel('f(x)');
grid on;        
      
