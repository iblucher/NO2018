x=randn([50 2]);
x1=[ones(50,1) x];
theta=[0.5,1,-1];
y=sign(x1*theta');
data=[x y];
%t=linspace(-4,4,50);
%scatter(x(:,1),x(:,2))
%hold on 
%plot(t,t+0.5)
[X,Y]=meshgrid(-4:.2:4, -4:.2:4)
d=size(X,1);
Z=nan(d);
for i=1:d
    for j=1:d
    Z(i,j)=F([0.5,X(1,i),Y(j,1)],data);
    end
end
hold off
surf(X,Y,Z)