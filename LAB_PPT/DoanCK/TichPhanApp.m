classdef TichPhanApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = private)
        UIFigure            matlab.ui.Figure
        FunctionLabel      matlab.ui.control.Label
        FunctionEditField  matlab.ui.control.EditField
        RangeLabel         matlab.ui.control.Label
        RangeEditField     matlab.ui.control.EditField
        SegmentsLabel      matlab.ui.control.Label
        SegmentsEditField  matlab.ui.control.EditField
        CalculateButton    matlab.ui.control.Button
        ResultLabel        matlab.ui.control.Label
        GraphAxes          matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: CalculateButton
        function CalculateButtonPushed(app, ~)
            % Get input values
            func = app.FunctionEditField.Value;
            range = str2num(app.RangeEditField.Value);
            N = str2double(app.SegmentsEditField.Value);

            % Calculate integrals using different methods
            result_trapezoidal = trapezoidal(func, range, N);
            result_simpson = simpson(func, range, N);
            result_exact = integral(func, range(1), range(2));

            % Display results
            result_str = ['Trapezoidal: ' num2str(result_trapezoidal, '%.10f') ...
                          '\nSimpson: ' num2str(result_simpson, '%.10f') ...
                          '\nExact: ' num2str(result_exact, '%.10f')];
            app.ResultLabel.Text = result_str;

            % Plot the function
            x_values = linspace(range(1), range(2), 1000);
            y_values = eval(func);
            plot(app.GraphAxes, x_values, y_values);
            title(app.GraphAxes, 'Graph of f(x)');
            xlabel(app.GraphAxes, 'x');
            ylabel(app.GraphAxes, 'f(x)');
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100, 100, 640, 480];
            app.UIFigure.Name = 'Tich Phan App';
            app.UIFigure.Resize = 'off';

            app.FunctionLabel = uilabel(app.UIFigure);
            app.FunctionLabel.Position = [20, 400, 100, 22];
            app.FunctionLabel.Text = 'Function:';

            app.FunctionEditField = uieditfield(app.UIFigure, 'text');
            app.FunctionEditField.Position = [130, 400, 200, 22];

            app.RangeLabel = uilabel(app.UIFigure);
            app.RangeLabel.Position = [20, 350, 100, 22];
            app.RangeLabel.Text = 'Range [a, b]:';

            app.RangeEditField = uieditfield(app.UIFigure, 'text');
            app.RangeEditField.Position = [130, 350, 200, 22];

            app.SegmentsLabel = uilabel(app.UIFigure);
            app.SegmentsLabel.Position = [20, 300, 100, 22];
            app.SegmentsLabel.Text = 'Segments (N):';

            app.SegmentsEditField = uieditfield(app.UIFigure, 'numeric');
            app.SegmentsEditField.Position = [130, 300, 200, 22];

            app.CalculateButton = uibutton(app.UIFigure, 'push');
            app.CalculateButton.Position = [130, 250, 100, 30];
            app.CalculateButton.Text = 'Calculate';
            app.CalculateButton.ButtonPushedFcn = createCallbackFcn(app, @CalculateButtonPushed, true);

            app.ResultLabel = uilabel(app.UIFigure);
            app.ResultLabel.Position = [20, 200, 300, 60];
            app.ResultLabel.Text = 'Results will be displayed here.';

            app.GraphAxes = uiaxes(app.UIFigure);
            app.GraphAxes.Position = [360, 50, 250, 300];
        end
    end

    methods (Access = public)

        % Construct app
        function app = TichPhanApp
            % Create UIFigure and components
            createComponents(app);

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end
end

% Function to calculate integral using trapezoidal rule
function result = trapezoidal(func, range, N)
    x_values = linspace(range(1), range(2), N+1);
    y_values = eval(func);
    h = (range(2) - range(1)) / N;
    result = h * (sum(y_values) - 0.5 * (y_values(1) + y_values(end)));
end

% Function to calculate integral using Simpson's rule
function result = simpson(func, range, N)
    x_values = linspace(range(1), range(2), N+1);
    y_values = eval(func);
    h = (range(2) - range(1)) / N;
    result = h / 3 * (y_values(1) + 4 * sum(y_values(2:2:N)) + 2 * sum(y_values(3:2:N-1)) + y_values(end));
end
