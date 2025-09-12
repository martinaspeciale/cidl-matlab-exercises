cd ..% Particle Swarm Optimization (PSO) Algorithm in MATLAB

% Define the objective function
objective_function = @(params) (params(:,1) - 4).^2 + (params(:,2) - 5).^2 + (params(:,3) + 6).^2; % known optimum: [4 5 -6]

% Define the bounds of the search space
bounds = [-10, -10, -10; 10, 10, 10];

% Define the parameters of the optimization
n_particles = 10;
max_iterations = 30;

w = 0.5;   % Inertia weight
c1 = 0.8;  % Cognitive acceleration coefficient
c2 = 0.9;  % Social acceleration coefficient

% Initialize the particles and velocities
particles = bounds(1,:) + rand(n_particles, 3) .* (bounds(2,:) - bounds(1,:));
velocities = zeros(n_particles, 3);

% Initialize the best positions and best costs
p_best_positions = particles;
best_costs = objective_function(particles);

% Initialize the global best position and global best cost
[global_best_cost, idx] = min(best_costs);
g_best_position = p_best_positions(idx,:); % global best position

% Perform the optimization
for iter = 1:max_iterations
    % Update the velocities
    r1 = rand(n_particles, 3); % Random matrix for cognitive component
    r2 = rand(n_particles, 3); % Random matrix for social component

    % Cognitive component
    cognitive_component = c1 * r1 .* (p_best_positions - particles);

    % Social component
    social_component = c2 * r2 .* (repmat(g_best_position, n_particles, 1) - particles);

    % Update velocity
    velocities = w * velocities + cognitive_component + social_component;

    % Update the particles
    particles = particles + velocities;

    % Enforce the bounds of the search space
    particles = max(particles, bounds(1,:));
    particles = min(particles, bounds(2,:));

    % Evaluate the objective function
    costs = objective_function(particles);

    % Update the best positions and best costs
    is_best = costs < best_costs;
    p_best_positions(is_best,:) = particles(is_best,:);
    best_costs(is_best) = costs(is_best);

    % Update the global best position and global best cost
    [global_best_cost, idx] = min(best_costs);
    g_best_position = p_best_positions(idx,:);

    % Print the progress
    fprintf('Iteration %d: Best Cost = %.6f\n', iter, global_best_cost);
end

% Print the results
fprintf('Global Best Position: [%f, %f, %f]\n', g_best_position(1), g_best_position(2), g_best_position(3));
fprintf('Global Best Cost: %f\n', global_best_cost);
